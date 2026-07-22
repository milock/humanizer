# Changelog

All notable changes to this project will be documented here. The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project follows semantic versioning.

## [1.1.0] — 2026-07-22

### Changed
- **Structure is now a first-class signal, integrated into the default pipeline** (not a separate mode). Motivated by the rise of transformer-classifier detectors (Pangram-class, now embedded in Substack, LinkedIn, and academic tools) that score *structural regularity* over vocabulary. Every pass now addresses structure and vocab together, structure first.
- Reframed the skill intro around the two kinds of reader — a person (who notices reframes, punchlines, buzzwords) and a statistical detector (which scores sentence-length uniformity, paragraph shape, formulaic transitions, and over-smoothed cadence). Named the core trap: polishing toward uniformity lowers human-perceived tells while *raising* a detector's score.
- Rewrote `references/patterns.md` §3.3 from "Staccato Overdose + Uniform Length" into **"Cadence & Structural Regularity — the #1 detector signal"**, with quantified checks for sentence-length burstiness and paragraph-shape variance, and a rule to fix it by *increasing* variance rather than evening it out.
- **Step 3 (severity gate):** uniform cadence/paragraph shape is now an *independent* full-rewrite trigger — a structurally uniform draft goes to full rewrite even when the vocabulary is clean.
- **Step 4 (rewrite):** fix structure before vocabulary; re-shape sentences and paragraphs before swapping words (word-level edits barely move a classifier); inject specific voice; do not flatten to even cadence on the way out.
- **Step 5 (self-audit):** Prompts 1–2 now read the draft as a statistical detector would (structure), not only as a human (vocabulary).

### Added
- Guardrails: **"Don't polish toward uniformity"** and **"Don't reach for gimmicks"** (zero-width characters, homoglyphs, unicode swaps, forced typos, and commercial "humanizer" tools do not survive a detector and can raise the score over time; the durable fix is genuine structural variance and specific voice).
- Sources: 2026 Pangram/classifier false-positive research (structural rewriting ~89% vs. synonym-swap ~34% evasion in one 10M-word test).

## [1.0.1] — 2026-04-29

### Changed
- Restructured `SKILL.md` to follow [Anthropic's progressive-disclosure pattern](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/best-practices). Core skill body went from 617 lines to 343 lines. Pattern catalog and channel/voice rules moved to `references/patterns.md` and `references/channels.md`, which Claude loads on demand.
- Tightened skill description in YAML frontmatter to use Anthropic's recommended "Use when..." trigger pattern.
- `install.sh` now copies both `SKILL.md` and `references/` into the install target.

## [1.0.0] — 2026-04-29

Initial public release.

### Added
- Six-step humanizer pipeline (auto-detect channel → optional voice calibration → pattern scan → severity gate → rewrite → self-audit → emit).
- Severity tiers (CRITICAL / HIGH / MEDIUM / LOW) with explicit action mapping.
- 16 structural pattern detectors (dramatic reframe, manufactured punchline, staccato overdose, performative directness, runway sentences, persuasive authority tropes, tailing negations, elegant variation, copula avoidance, inspirational pivot, vulnerability performance, anaphora, universal authority without source, fragmented headers, credential-stacking / stat-bomb / tension-colon openers).
- Three-tier vocabulary system (always-replace / cluster-flag / density-flag) with domain-terminology exemption.
- Quantified punctuation budgets (em dash, exclamation, ellipsis, semicolon, rhetorical question).
- Banned openers list (hard cuts).
- Channel × Strictness matrix for 11 common writing channels.
- Per-channel hollow-failure-mode catalog.
- Stable output format with parseable section headers (Issues Found / Rewritten Draft / What Changed / Self-Audit / Final Version / Humanizer Report).
- Detect-only mode for read-only audits.
- Clean-but-hollow flag for drafts that pass the scan but lack substance.
- **Setup mode** — guided 7-question interview that produces a populated voice profile.
- Author voice profile template.
- Brand voice profile template.
- Worked before/after examples for email, LinkedIn, and blog intros.
- Stet protocol for honoring user overrides.
- Integration patterns for upstream drafting agents.
- Interoperability docs for Claude Code, Cursor, raw API, and CI.
