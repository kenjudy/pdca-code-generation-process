"""EvalReporter: collects scenario results and writes a Markdown report."""

import textwrap
from pathlib import Path

PHASE_NAMES = {
    "1a": "Analysis",
    "1b": "Planning",
    "2": "TDD Implementation",
    "3": "Verification",
    "4": "Retrospection",
}


class EvalReporter:
    def __init__(self):
        self.results: list[dict] = []

    def add(self, result: dict) -> None:
        self.results.append(result)

    def write_report(self, path: Path) -> Path:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(self._render())
        return path

    def _render(self) -> str:
        lines = []

        from datetime import datetime
        lines.append(f"# PDCA Eval Report — {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")

        # Summary table
        lines.append("## Summary\n")
        lines.append("| Scenario | Phase | Score | Threshold | GEval | Mechanical |")
        lines.append("|----------|-------|-------|-----------|-------|------------|")
        for r in self.results:
            score_str = f"{r['geval_score']:.2f}" if r["geval_score"] is not None else "n/a"
            phase = PHASE_NAMES.get(r["prompt_id"], r["prompt_id"])
            mech_ok = all(c.passed for c in r["mechanical"])
            lines.append(
                f"| {r['scenario_id']} | {phase} | {score_str} | {r['geval_threshold']:.2f}"
                f" | {'✅' if r['geval_passed'] else '❌'} | {'✅' if mech_ok else '❌'} |"
            )
        lines.append("")

        # Per-scenario detail
        lines.append("## Scenario Details\n")
        for r in self.results:
            phase = PHASE_NAMES.get(r["prompt_id"], r["prompt_id"])
            score_str = f"{r['geval_score']:.2f}" if r["geval_score"] is not None else "n/a"

            lines.append(f"### {r['scenario_id']} ({phase})\n")
            lines.append(
                f"**GEval:** {score_str} / threshold {r['geval_threshold']:.2f}"
                f" {'✅' if r['geval_passed'] else '❌'}"
            )

            # Mechanical checks
            lines.append("\n**Mechanical checks:**\n")
            if r["mechanical"]:
                for c in r["mechanical"]:
                    lines.append(f"- {'✅' if c.passed else '❌'} `{c.field}` — {c.detail}")
            else:
                lines.append("- *(none defined)*")

            # Judge reasoning
            if r.get("geval_reason"):
                lines.append("\n**Judge reasoning:**\n")
                lines.append(f"> {r['geval_reason'].strip()}")

            # Input
            lines.append("\n**Input:**\n")
            lines.append("```")
            lines.append(textwrap.dedent(r["input"]).strip())
            lines.append("```")

            # Model output
            lines.append("\n**Model output:**\n")
            lines.append("```")
            lines.append(r["output"].strip())
            lines.append("```")

            lines.append("")

        return "\n".join(lines)
