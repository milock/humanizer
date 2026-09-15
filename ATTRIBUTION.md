# Attribution

Humanizer's pattern catalog and detection methodology synthesize work from several sources. This document credits them.

---

## September 2026 editing enhancements

Version 1.2 adapts Michael Lock's `sg-writing-deslop` work in [Super Green's sg-marketplace](https://github.com/Super-Green/sg-marketplace): approved voice takes precedence, facts and asks survive editing, and a final audit checks meaning as well as style. The portable calibration reference expands those ideas without requiring the marketplace plugins.

The research credits below are inherited provenance notes. This release does not establish their numerical claims or treat the catalogue as a validated authorship test. Historical detector-evasion percentages remain only in the changelog's account of v1.1.0; active guidance makes no such claim.

## Research and pattern sources

### Carnegie Mellon AI-writing word-frequency study (2025)
Vocabulary tier system in [`references/patterns.md`](references/patterns.md) §4 draws from CMU's frequency analysis of LLM output vs. human writing. The precise study and calibration have not been verified for this release; treat the word tiers as editorial defaults.

### Wikipedia "Signs of AI Writing"
Several structural patterns in [`references/patterns.md`](references/patterns.md) §3 — particularly puffery, persuasive authority tropes, vague attributions, and inspirational pivots — are informed by the editor community's running catalog at [Wikipedia: WikiProject AI Cleanup / Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:WikiProject_AI_Cleanup/Signs_of_AI_writing).

### Buffer 52M-post LinkedIn analysis (2025)
The structural-tells angle — particularly the priority of dramatic reframes, manufactured punchlines, and uniform sentence length over vocabulary swaps — draws on Buffer's 2025 analysis of LinkedIn posts. Their finding that structural patterns predict AI-likeness more reliably than word choice shaped the scan order in the Humanizer skill.

### blader/ai-detection
Open-source AI-detection taxonomy. Several pattern categorizations in §3 (anaphora, copula avoidance, fragmented headers, present-participle stacking) trace to this project's pattern inventory.

### conor-humanizer
The 3-tier vocabulary model (always-replace / cluster-flag / density-flag) is adapted from this project's word-frequency tiering.

### jalaalrd/ai-writing-tells
The quantified punctuation budgets in `references/patterns.md` §6 (em dash max 1/500 words, exclamation 1/1,000 words, ellipsis 1/piece) follow the conventions established by this project.

### "The Humanizer" LinkedIn archetype catalog
The credential-stack / stat-bomb / tension-colon / common-belief-then-counter opener taxonomy in §3.16 is drawn from public LinkedIn-post analysis and the patterns surfaced in that catalog.

---

## Methodology references

The output format (Issues Found / Rewritten Draft / Self-Audit / Final Version / Humanizer Report) is original to this skill but draws structural inspiration from:

- **Code review tools** — the diff-plus-rationale shape mirrors how reviewers annotate PRs.
- **Linting reports** — severity tiers (CRITICAL / HIGH / MEDIUM / LOW) mirror ESLint, Pylint, and similar.

---

## Format conformance

The skill follows [Anthropic's Agent Skills specification](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills) — YAML frontmatter with `name` and `description`, body under 500 lines, progressive-disclosure pattern with `references/` files loaded on demand.

---

## How to credit Humanizer

If you adapt or build on Humanizer in a public project, a link in your README is plenty:

```markdown
Built with [Humanizer](https://github.com/milock/humanizer).
```

For academic or research citations:

```bibtex
@software{humanizer,
  author = {Humanizer contributors},
  title = {Humanizer: a portable writing skill for scrubbing AI tells},
  year = {2026},
  url = {https://github.com/milock/humanizer}
}
```
