"""Tests for the eval executor (mocked — no real API calls)."""

import tempfile
import unittest
from pathlib import Path
from unittest.mock import MagicMock

from eval.executor import run_phase

PROMPT_CONTENT = "# Plan Phase\nGuide the user through architecture discovery."
SCENARIO_INPUT = "I need to add OAuth2 to our Express API."
MOCK_RESPONSE_TEXT = "Let us start by discovering existing auth patterns in the codebase."


def make_prompt_file(content: str = PROMPT_CONTENT) -> Path:
    """Write content to a temp file and return its path."""
    tmp = tempfile.NamedTemporaryFile(mode="w", suffix=".md", delete=False)
    tmp.write(content)
    tmp.close()
    return Path(tmp.name)


def make_mock_client(response_text: str = MOCK_RESPONSE_TEXT) -> MagicMock:
    """Return a mock Anthropic client instance whose messages.create returns response_text."""
    mock_client = MagicMock()
    mock_message = MagicMock()
    mock_message.content = [MagicMock(text=response_text)]
    mock_client.messages.create.return_value = mock_message
    return mock_client


class TestRunPhaseReturnType(unittest.TestCase):
    """Degenerate case — establishes return type."""

    def test_run_phase_returns_string(self):
        prompt_path = make_prompt_file()
        result = run_phase(prompt_path, SCENARIO_INPUT, _client=make_mock_client())
        self.assertIsInstance(result, str)


class TestRunPhaseRequestConstruction(unittest.TestCase):
    """Verify the executor builds the Anthropic request correctly."""

    def test_uses_file_content_as_system_prompt(self):
        prompt_path = make_prompt_file(PROMPT_CONTENT)
        mock_client = make_mock_client()
        run_phase(prompt_path, SCENARIO_INPUT, _client=mock_client)
        call_kwargs = mock_client.messages.create.call_args.kwargs
        self.assertEqual(call_kwargs["system"], PROMPT_CONTENT)

    def test_sends_scenario_as_user_message(self):
        prompt_path = make_prompt_file()
        mock_client = make_mock_client()
        run_phase(prompt_path, SCENARIO_INPUT, _client=mock_client)
        call_kwargs = mock_client.messages.create.call_args.kwargs
        messages = call_kwargs["messages"]
        self.assertEqual(len(messages), 1)
        self.assertEqual(messages[0]["role"], "user")
        self.assertEqual(messages[0]["content"], SCENARIO_INPUT)

    def test_passes_model_to_api(self):
        prompt_path = make_prompt_file()
        mock_client = make_mock_client()
        run_phase(prompt_path, SCENARIO_INPUT, model="claude-haiku-4-5-20251001", _client=mock_client)
        call_kwargs = mock_client.messages.create.call_args.kwargs
        self.assertEqual(call_kwargs["model"], "claude-haiku-4-5-20251001")


class TestRunPhaseResponse(unittest.TestCase):
    """Verify the executor extracts and returns the model's text."""

    def test_returns_model_response_text(self):
        prompt_path = make_prompt_file()
        result = run_phase(prompt_path, SCENARIO_INPUT, _client=make_mock_client(MOCK_RESPONSE_TEXT))
        self.assertEqual(result, MOCK_RESPONSE_TEXT)

    def test_returns_non_empty_string(self):
        prompt_path = make_prompt_file()
        result = run_phase(prompt_path, SCENARIO_INPUT, _client=make_mock_client("non-empty response"))
        self.assertTrue(len(result) > 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
