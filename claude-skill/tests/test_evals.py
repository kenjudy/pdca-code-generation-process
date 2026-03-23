"""LLM-as-judge evaluation tests for PDCA phase prompts.

These tests invoke the real Anthropic API and use DeepEval GEval for
rubric-based scoring. They are expensive (~$2-5 per full run) and slow.

Run with:
    uv run ./run-evals.sh

Do NOT run in CI — they are excluded from the default test suite via the
`eval` pytest marker.
"""

import json
import pytest
from pathlib import Path

from deepeval.metrics import GEval
from deepeval.models import AnthropicModel
from deepeval.test_case import LLMTestCase, LLMTestCaseParams

from eval.executor import run_phase
from eval.mechanical import check_mechanical
from eval.rubrics.rubric_1a import CRITERIA as CRITERIA_1A, THRESHOLD as THRESHOLD_1A
from eval.rubrics.rubric_1b import CRITERIA as CRITERIA_1B, THRESHOLD as THRESHOLD_1B
from eval.rubrics.rubric_2 import CRITERIA as CRITERIA_2, THRESHOLD as THRESHOLD_2
from eval.rubrics.rubric_3 import CRITERIA as CRITERIA_3, THRESHOLD as THRESHOLD_3
from eval.rubrics.rubric_4 import CRITERIA as CRITERIA_4, THRESHOLD as THRESHOLD_4

JUDGE_MODEL = AnthropicModel(model="claude-haiku-4-5-20251001")

pytestmark = pytest.mark.eval

CLAUDE_SKILL_DIR = Path(__file__).parent.parent
SCENARIOS_DIR = CLAUDE_SKILL_DIR / "eval" / "scenarios"
PHASE_PROMPTS_DIR = CLAUDE_SKILL_DIR / "src" / "core" / "references"

PROMPT_FILE = {
    "1a": "plan-prompts.md",
    "1b": "plan-prompts.md",
    "2": "do-prompts.md",
    "3": "check-prompts.md",
    "4": "act-prompts.md",
}


def load_scenarios(prompt_id: str) -> list[dict]:
    """Load scenarios for a given prompt_id from the scenarios directory."""
    scenario_file = SCENARIOS_DIR / f"{prompt_id}_scenarios.json"
    with open(scenario_file) as f:
        return json.load(f)


def _rubric_for_prompt(prompt_id: str) -> tuple[str, float]:
    """Return (criteria_text, threshold) for a given prompt_id."""
    rubrics = {
        "1a": (CRITERIA_1A, THRESHOLD_1A),
        "1b": (CRITERIA_1B, THRESHOLD_1B),
        "2":  (CRITERIA_2,  THRESHOLD_2),
        "3":  (CRITERIA_3,  THRESHOLD_3),
        "4":  (CRITERIA_4,  THRESHOLD_4),
    }
    if prompt_id not in rubrics:
        raise ValueError(f"No rubric registered for prompt_id: {prompt_id!r}")
    return rubrics[prompt_id]


def _run_scenario(scenario: dict) -> dict:
    """Run executor + mechanical + GEval for one scenario. Returns result dict."""
    prompt_id = scenario["prompt_id"]
    phase_prompt_path = PHASE_PROMPTS_DIR / PROMPT_FILE[prompt_id]

    output = run_phase(phase_prompt_path, scenario["input"])
    mechanical_results = check_mechanical(output, scenario["expected_signals"])

    criteria, threshold = _rubric_for_prompt(prompt_id)
    metric = GEval(
        name=f"pdca_{prompt_id}_compliance",
        criteria=criteria,
        evaluation_params=[LLMTestCaseParams.INPUT, LLMTestCaseParams.ACTUAL_OUTPUT],
        threshold=threshold,
        model=JUDGE_MODEL,
    )
    test_case = LLMTestCase(input=scenario["input"], actual_output=output)
    metric.measure(test_case)

    return {
        "scenario_id": scenario["scenario_id"],
        "output": output,
        "mechanical": mechanical_results,
        "geval_score": metric.score,
        "geval_passed": metric.is_successful(),
    }


def _assert_result_shape(result: dict) -> None:
    assert result is not None, "eval harness must not error"
    assert "mechanical" in result
    assert "geval_score" in result
    assert isinstance(result["geval_score"], float)


class TestPrompt1aEvals:
    """End-to-end LLM eval for PDCA prompt 1a (Analysis Phase)."""

    @pytest.mark.parametrize("scenario", load_scenarios("1a"), ids=lambda s: s["scenario_id"])
    def test_1a_scenario(self, scenario):
        _assert_result_shape(_run_scenario(scenario))


class TestPrompt1bEvals:
    """End-to-end LLM eval for PDCA prompt 1b (Planning Phase)."""

    @pytest.mark.parametrize("scenario", load_scenarios("1b"), ids=lambda s: s["scenario_id"])
    def test_1b_scenario(self, scenario):
        _assert_result_shape(_run_scenario(scenario))


class TestPrompt2Evals:
    """End-to-end LLM eval for PDCA prompt 2 (DO / TDD Implementation)."""

    @pytest.mark.parametrize("scenario", load_scenarios("2"), ids=lambda s: s["scenario_id"])
    def test_2_scenario(self, scenario):
        _assert_result_shape(_run_scenario(scenario))


class TestPrompt3Evals:
    """End-to-end LLM eval for PDCA prompt 3 (Check Phase)."""

    @pytest.mark.parametrize("scenario", load_scenarios("3"), ids=lambda s: s["scenario_id"])
    def test_3_scenario(self, scenario):
        _assert_result_shape(_run_scenario(scenario))


class TestPrompt4Evals:
    """End-to-end LLM eval for PDCA prompt 4 (Act / Retrospection)."""

    @pytest.mark.parametrize("scenario", load_scenarios("4"), ids=lambda s: s["scenario_id"])
    def test_4_scenario(self, scenario):
        _assert_result_shape(_run_scenario(scenario))
