---
name: humanizer
description: Final pre-delivery scrub for AI tells on every draft. Use when the user asks to humanize a draft, scrub AI tells, run a final review or pre-publish check, de-robot text, audit AI-likeness, or prepare any draft (email, Slack, LinkedIn, blog, case study, landing page, newsletter, sales collateral, meeting agenda, feedback note) before sending or publishing. First-run onboarding via "humanizer setup" or "configure humanizer". Returns a corrected draft plus a structured report of issues found.
---

# Humanizer

Final pre-delivery scrub for AI tells. Run on every draft longer than a single sentence, external or internal — emails, Slack threads, LinkedIn, blog posts, case studies, sales collateral, newsletters, meeting agendas with prose, feedback notes. Single-line replies are exempt.

A draft can use zero banned words and still read like a robot if it leans on dramatic reframes, staccato rhythm, and manufactured punchlines, which is why the scan runs structural before vocab before positive checks before context.

**A draft is read by two kinds of reader, and they weigh different things.** A person notices reframes, punchlines, and buzzwords — the tells this skill has always caught. A statistical detector (Pangram-class, now running on Substack, LinkedIn, and academic tools) barely reads vocabulary; it scores **structural regularity** — uniform sentence length, evenly-shaped paragraphs, formulaic transitions, and the over-smoothed cadence a polishing pass leaves behind. Both readers are always in play, so every pass addresses structure and vocab together — and runs structure first, because it is the higher-signal axis and the one this skill historically under-weighted (in one test, structural rewriting evaded detection ~89% of the time versus ~34% for synonym-swapping). The trap is polishing toward uniformity: smoothing cadence flat lowers human-perceived tells while *raising* a detector's score. Increase variance; never even it out. The cadence check lives in `references/patterns.md` §3.3.

Severity maps to action:

| Severity | Meaning | Action |
|---|---|---|
| **CRITICAL (P0)** | Credibility killer. Reader loses trust. | Always fix. No exceptions. |
| **HIGH (P1)** | Clear AI tell. Reader notices. | Fix unless the pattern is intentional and earned. |
| **MEDIUM (P2)** | Stylistic drag. Accumulates. | Fix if 2+ in same piece, or if combined with other patterns. |
| **LOW** | Watch-list. Only flag in clusters. | Note if density is high; otherwise leave. |

## Reference files (load on demand)

- **`references/patterns.md`** — full AI-tell catalog: full-rewrite threshold (§1), CRITICAL credibility killers (§2), 16 HIGH structural patterns (§3), 3-tier vocabulary system (§4), MEDIUM stylistic drag (§5), punctuation budgets (§6), banned openers (§7). Read this during Step 2 (Pattern Scan) and Step 4 (Rewrite).
- **`references/channels.md`** — channel auto-detect cues, channel × strictness matrix, per-channel hollow-failure modes, ask-vs-decide rules, voice carve-outs (§8). Read this during Step 0 (Channel Detection) and Step 1 (Voice Calibration).

---

## Setup (Optional)

This skill works out of the box. Two optional configurations make it sharper:

1. **Author voice profile** — a markdown file describing the writer's natural voice (sentence-length distribution, register, paragraph-opener habits, recurring phrases, things to leave alone). Pass the path when invoking, or auto-load it for first-person drafts.
2. **Brand voice profile** — same shape, for client-facing or organizational copy. Pass the path for blog/case-study/landing-page/marketing-email work.

Without either profile, the skill preserves the draft's existing voice and applies the universal rules.

**Two ways to set up:**
- **Guided:** invoke `humanizer setup` (or "set up humanizer" / "configure humanizer"). Walks through a short interview and produces a populated voice profile. See **Setup Mode** below.
- **Manual:** copy `examples/author-voice.example.md` or `examples/brand-voice.example.md`, fill in the details, pass the path.

---

## Workflow

Six-step pipeline:

```
0. Auto-detect channel + voice target
1. Voice calibration (conditional)
2. Pattern scan (structural → vocab → positive → context)
3. Severity gate (patch vs. full rewrite; clean-but-hollow check)
4. Rewrite at chosen depth
5. Self-audit (mandatory long-form; conditional short-form)
6. Emit final draft + humanizer report
```

### Step 0 — Auto-detect channel

Infer channel silently from cues (greeting/salutation, file path, word count, hashtags, code fences, voice cues). See `references/channels.md` → Auto-Detect Cues. Default to `generic long-form` if ambiguous and note the assumption in the final report. Don't ask unless two or more channels are genuinely plausible.

### Step 1 — Voice calibration (conditional)

Skip by default. Run only when one of these is true:

1. The user pastes a writing sample and asks for voice-matched output.
2. An author voice profile is configured and the draft is first-person / personal.
3. A brand voice profile is configured and the draft is client-facing or organizational.
4. The draft was produced by an upstream drafting agent with its own voice rules; the humanizer runs as a final pass and respects its register.

When calibrating from a sample, capture a six-line voice profile: sentence-length distribution, word-choice level, paragraph openers, punctuation habits, recurring phrases, transition style. Keep in working memory for Steps 4 and 5.

Never fabricate a voice profile. If no trigger fires, preserve the draft's existing voice rather than imposing one.

### Step 2 — Pattern scan

Fixed order — structural tells are load-bearing; vocab tells are surface. **Read `references/patterns.md` before scanning.**

1. **Dramatic reframe + punchline structures** (patterns §3.1, §3.2) — the highest-signal tells
2. **Structural patterns** (§3.3 through §3.16)
3. **Vocabulary tiers** (§4)
4. **Positive checks** — is there a point of view, a concrete detail, an earned opener?
5. **Context checks** — punctuation budgets (§6), banned openers (§7), register-appropriate forms

Tally hits. Group vocab hits by category — category count feeds Step 3.

### Step 3 — Severity gate

**Patch vs. full rewrite.** Trigger full rewrite if all three are true (per `references/patterns.md` §1):
- 5+ Tier 1/Tier 2 vocab hits
- 3+ distinct pattern categories triggered
- Uniform sentence length — three-plus consecutive sentences within 2 words of each other

**Structure can trigger a rewrite on its own.** If cadence and paragraph shape are uniform across the piece (`references/patterns.md` §3.3) — the dominant signal for a statistical detector — go to full rewrite even when the vocab is clean and no other category fired. Patching smooths the surface; it does not add the structural variance a uniform draft is missing.

Otherwise patch mode. Surgical edits only, leave the rest alone.

**Clean-but-hollow flag.** If the draft passes the scan but says nothing — no concrete claim, no specific example, no defensible point of view — flag `[HOLLOW]` explicitly. A clean-style draft with no substance is still broken.

### Step 4 — Rewrite

Produce the rewrite at the depth Step 3 chose. Preserve the writer's voice and argument. The humanizer removes tells; it does not impose a house style on a draft that already has one.

Fix structure before vocabulary. Re-shaping sentence lengths and paragraph blocks does more than swapping words — for a human reader it kills the robotic cadence, and for a detector it is nearly the whole game (word-level edits barely move a classifier). Where the draft is generic, add specific voice: a real detail, a named example, a stated opinion. Do not flatten the result into even cadence on the way out.

For **patch mode**, show only edited spans with minimal surrounding context. For **full rewrite**, produce the full replacement.

### Step 5 — Self-audit (mandatory second pass)

The load-bearing step of the pipeline. Do not skip on long-form.

**Mandatory for:** blog posts, case studies, sales collateral, newsletters, LinkedIn posts, any external email >4 sentences, any draft that triggered full rewrite in Step 3.

**Conditional for:** Slack messages, short internal emails, CTAs, subject lines — skip **only if** Step 2 flagged nothing.

Two prompts, asked internally, answered in writing:

> **Prompt 1:** "What makes the below so obviously AI generated?"
> List every residual tell in the rewritten draft — vocabulary *and* structure. Read part of it as a statistical detector would: name any uniform sentence-length band, same-shape paragraph runs, formulaic transitions, over-hedged neutral tone, or over-smoothed polish, since that is what the machine weights most heavily. Do not protect your own work. If none, say "None" with a one-sentence justification.

> **Prompt 2:** "Now make it not obviously AI generated."
> Revise against every tell surfaced in Prompt 1. Favor restructuring sentences and paragraphs over swapping words — word-level edits barely move a detector, and structure is where both readers are looking.

If Prompt 1 returns "None" and the justification holds, skip Prompt 2 and emit.

### Step 6 — Emit final + report

Use the Output Format below. Downstream agents that parse the output rely on a stable shape — keep the section headers consistent.

---

## Output Format

Two modes. Default to **Rewrite**. Use **Detect** when the user says "scan," "check," "audit" without asking for a rewrite. **Setup Mode** runs only on explicit setup invocation.

### Rewrite Mode (default)

```
## Issues Found

- **[CRITICAL]** "<verbatim offending text>" — <why it reads AI> → <fix direction>
- **[HIGH]** "<verbatim>" — <reason> → <fix>
- **[MEDIUM]** "<verbatim>" — <reason> → <fix>

(Group by severity. Quote offending text verbatim — vague paraphrases let bad lines slip back in.)

## Rewritten Draft

<full corrected draft — no preamble, no commentary, copy-paste ready>

## What Changed

- <1-line summary of major edit>
- <max 6 bullets; major edits only>

## Self-Audit

"What makes the above so obviously AI generated?"

- <residual tell #1>
- <residual tell #2>

(or: "None detected.")

## Final Version

<full post-audit revision — this is what the user copies>

(If Self-Audit found nothing, repeat the Rewritten Draft verbatim under this header so downstream parsers always find a Final Version section.)

## Humanizer Report

- **Channel detected:** <email | slack | linkedin | newsletter | case-study | blog | agenda | landing-page | generic long-form>
- **Voice loaded:** <none | author profile | brand profile | sample>
- **Rewrite depth:** <patch | full>
- **Clean-but-hollow:** <no | yes + what's missing>
- **Notes:** <punctuation swaps, register corrections, other context-layer fixes>
```

### Detect Mode

```
## Issues Found

- **[CRITICAL/HIGH/MEDIUM/LOW]** "<verbatim>" — <reason>

## Assessment

<2-3 sentences: overall AI-likeness + channel fit. Flag clean-but-hollow if applicable.>
```

### Clean-But-Hollow Flag

When the draft has no CRITICAL/HIGH issues but no concrete claims, numbers, named entities, or examples, add this to Issues Found:

`- **[HOLLOW]** Passes AI scan but lacks substance: <what's missing — specific number, named example, stake>.`

In Rewrite mode, the Final Version must add substance, not just polish. Never silently approve a hollow draft. See `references/channels.md` → Per-Channel Hollow Failure Modes for what counts as hollow per channel.

### Nothing Flagged

If the draft is clean: `## Issues Found` = `- None detected.`, Rewritten Draft = original, Self-Audit still runs, Final Version emitted verbatim. **Emit all section headers even on a clean pass** — downstream agents parse by header. Detect mode is the one exception; it does not emit `## Final Version`.

### Setup Mode

Triggered when the user says "humanizer setup", "configure humanizer", "set up my voice profile", "onboard me".

The goal is a populated voice profile saved to a path the user controls. Don't overdesign the interview; capture what's load-bearing for AI-tells detection and stop.

Interview flow — ask one question at a time. Wait for an answer. Skip any section the user says "skip" to. Aim for ≤7 minutes total.

```
Q1. Who's this profile for?
    a) Me, personally (first-person — emails, LinkedIn, Slack, internal notes)
    b) A brand or organization (we voice — blog, case studies, marketing copy)
    c) Both (fill out two profiles back to back)

Q2. What do you actually write?
    Pick all that apply: email · Slack · LinkedIn · blog · case study · newsletter ·
    landing page · sales collateral · meeting agenda · feedback note · other

Q3. Paste 1–3 short samples of your natural writing.
    (Anything you've actually sent or published. 3–10 sentences each.)

Q4. Quirks to preserve.
    Patterns that look AI-ish in isolation but are actually you/your brand?
    Examples: short fragments, "And/But" sentence starts, one-line paragraphs,
    specific terms of address (Dr., Professor), house spelling, idioms, sign-offs.

Q5. Hard nos.
    Phrases, tropes, or framings you NEVER want to see?
    Examples: industry clichés, fear-mongering language, specific banned words
    beyond the universal Tier 1 list, idioms that don't fit your audience.

Q6. Punctuation preferences.
    a) Em dashes: allowed (default), reduced (max 1 / 500 words), or banned?
    b) Exclamation points: default, casual channels only, or never?
    c) Anything else? (e.g., Oxford comma always, no semicolons.)

Q7. Domain vocabulary that should be exempt from filler-word checks.
    Industry terms where words like "significant," "critical," "comprehensive"
    are load-bearing rather than filler.

Q8. Where should the profile be saved?
    Suggest a default (~/.humanizer/author-voice.md or ./voice/author.md) — let the
    user override. Confirm before writing.
```

**Output:** a markdown file at the user-chosen path, populated using the templates in `examples/`. After saving, print:

```
Voice profile saved to <path>.

To use it:
  • Pass --voice <path> when invoking, OR
  • Set HUMANIZER_AUTHOR_VOICE=<path>, OR
  • Reference it in your project's agent config so the skill auto-loads it.

To edit later: open the file directly. To re-run: "humanizer setup --replace".
```

**Re-running setup.** If the profile already exists, default to `--update` (additive — only ask questions whose answers can't be inferred). User must pass `--replace` to start over.

**Brand profile after author profile.** When Q1 = "Both", run the same interview a second time with brand framing.

**Don't ask** the user to enumerate the universal Tier 1 vocab list, structural patterns, or punctuation budgets — those are built in. Setup only captures what varies per user/brand.

---

## Worked Mini-Example

**Input (Slack draft):** "Quick update — we're leveraging the new workflow to streamline onboarding and it's been transformative for the team."

**Output:**

```
## Issues Found

- **[CRITICAL]** "leveraging" — Tier 1 vocab → "using"
- **[CRITICAL]** "streamline" — Tier 1 vocab → "speed up" or cut
- **[CRITICAL]** "transformative" — Tier 1 vocab → replace with a concrete result
- **[HOLLOW]** Passes scan but no specifics: which workflow? how much faster?

## Rewritten Draft

Quick update: the new onboarding workflow is saving us about a day per new hire.

## What Changed

- Swapped three Tier 1 words for plain verbs
- Added concrete result (day per hire) to replace vague praise
- Replaced em dash with colon (cleaner for short Slack message)

## Self-Audit

"What makes the above so obviously AI generated?"

- None detected. "Quick update:" reads natural for Slack.

## Final Version

Quick update: the new onboarding workflow is saving us about a day per new hire.

## Humanizer Report

- Channel detected: slack
- Voice loaded: none
- Rewrite depth: patch
- Clean-but-hollow: no (added specifics)
- Notes: em dash → colon
```

For longer worked examples (email, LinkedIn, blog), see `examples/before-after-*.md`.

---

## Sources

Detection patterns synthesized from:
- Carnegie Mellon (2025) AI-writing word-frequency study
- Wikipedia "Signs of AI Writing" editor guidance
- Buffer 52M-post LinkedIn analysis (2025)
- blader/ai-detection open-source taxonomy
- conor-humanizer 3-tier vocabulary model
- jalaalrd/ai-writing-tells quantified budgets
- "The Humanizer" LinkedIn archetype catalog
- Pangram/classifier false-positive research (2026): structure — sentence-length variance and paragraph shape — is the dominant statistical-detector signal (structural rewriting ~89% vs. synonym-swap ~34% evasion in one 10M-word test); over-polishing and commercial humanizer tools *increase* detectability over time; encoding tricks (zero-width chars, homoglyphs) are normalized out before scoring

---

## Guardrails

### Stet Protocol

Sometimes a flagged pattern is the right call — a tricolon that's actually earned, a short sentence doing real work, a stylistic choice that reads as the author's actual register. When the user says "keep it," "stet," "leave this," or "that's intentional":

1. Honor the override for this draft and any subsequent re-run.
2. Do not re-flag the same span in the Self-Audit pass.
3. Do not propagate the stet to other drafts — it's a one-piece decision, not a permanent rule change.
4. If the user overrides the same pattern three-plus times across different drafts, surface it: "You've kept [pattern] in 3+ drafts. Want me to add it to your voice profile carve-outs?"

### What NOT to Do

- **Don't strip voice to hit the checklist.** Short sentences, fragments, and "And"/"But" starts can be intentional. The humanizer removes tells; it does not normalize every piece into beige corporate prose.
- **Don't add words for the sake of it.** If a sentence is tight and clear, don't lengthen it to avoid "staccato." The staccato tell is about uniformity across the whole piece, not individual short sentences.
- **Don't polish toward uniformity.** Smoothing cadence flat, equalizing paragraph shapes, and hedging every claim to neutral reduces *human*-perceived tells while *raising* a statistical detector's score — the two readers pull opposite ways here. Preserve or increase structural variance and keep the small imperfections; a perfectly even draft is a machine signature.
- **Don't reach for gimmicks.** Zero-width characters, homoglyphs, unicode swaps, forced typos, and commercial "humanizer" tools do not survive a detector — text is normalized before scoring, and a tool's consistent rewrite signature becomes a *new* pattern detectors retrain on. The only durable fix is genuine structural variance and specific voice; if a draft is fully machine-generated, the honest answer is to actually write it.
- **Don't fabricate replacements.** If you're cutting a vague authority claim ("studies show..."), don't invent a source. Cut the claim or flag it with `[ADD SPECIFIC SOURCE OR CUT]` inline.
- **Don't rewrite past the user's intent.** If the piece is meant to be punchy (ad headline, stop-scroll caption, subject line), the structural rules loosen. Judgment over mechanical application.
- **Don't silently approve a hollow draft.** A draft that passes every tell but says nothing specific is still broken. Flag `[HOLLOW]` and let the user decide.
- **Don't decline the task; escalate instead.** If a full rewrite would require replacing >80% of the words, the draft is a ghost-write request, not a humanizing task. Return it with a note rather than fabricating new content.
