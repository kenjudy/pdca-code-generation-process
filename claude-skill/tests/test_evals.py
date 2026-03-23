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
from eval.rubrics.rubric_1a import CRITERIA, THRESHOLD

JUDGE_MODEL = AnthropicModel(model="claude-haiku-4-5-20251001")

pytestmark = pytest.mark.eval

CLAUDE_SKILL_DIR = Path(__file__).parent.parent
SCENARIOS_DIR = CLAUDE_SKILL_DIR / "eval" / "scenarios"
PHASE_PROMPTS_DIR = CLAUDE_SKILL_DIR / "src" / "core" / "references"


def load_scenarios(prompt_id: str) -> list[dict]:
    """Load scenarios for a given prompt_id from the scenarios directory."""
    scenario_file = SCENARIOS_DIR / f"{prompt_id}_scenarios.json"
    with open(scenario_file) as f:
        return json.load(f)


def _rubric_for_prompt(prompt_id: str) -> tuple[str, float]:
    """Return (criteria_text, threshold) for a given prompt_id."""
    if prompt_id == "1a":
        return CRITERIA, THRESHOLD
    raise ValueError(f"No rubric registered for prompt_id: {prompt_id!r}")


class TestPrompt1aEvals:
    """End-to-end LLM eval for PDCA prompt 1a (Analysis Phase)."""

    def _run_scenario(self, scenario: dict) -> dict:
        """Run executor + mechanical + GEval for one scenario. Returns result dict."""
        prompt_id = scenario["prompt_id"]
        phase_prompt_path = PHASE_PROMPTS_DIR / "plan-prompts.md"

        # 1. Invoke the model
        output = run_phase(phase_prompt_path, scenario["input"])

        # 2. Mechanical checks
        mechanical_results = check_mechanical(output, scenario["expected_signals"])

        # 3. GEval rubric score
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

    @pytest.mark.parametrize("scenario", load_scenarios("1a"), ids=lambda s: s["scenario_id"])
    def test_1a_scenario(self, scenario):
        result = self._run_scenario(scenario)
        assert result is not None, "eval harness must not error"
        assert "mechanical" in result
        assert "geval_score" in result
        assert isinstance(result["geval_score"], float)
