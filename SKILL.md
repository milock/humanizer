---
name: humanizer
description: Scrub AI writing patterns from finished drafts while preserving voice and facts. Use to humanize, de-robot, rewrite, or audit text before publishing. Supports author samples, brand guides, and optional voice-profile setup; returns edits and a structured report.
---

# Humanizer

Final pre-delivery scrub for AI tells. Run on every draft longer than a single sentence, external or internal — emails, Slack threads, LinkedIn, blog posts, case studies, sales collateral, newsletters, meeting agendas with prose, feedback notes. Single-line replies are exempt.

A draft can use zero banned words and still read like a robot if it leans on dramatic reframes, staccato rhythm, and manufactured punchlines, which is why the scan runs structural before vocab before positive checks before context.

Structure comes first because reshaping a paragraph changes which words survive. Check repeated reframes, manufactured punchlines, uniform cadence, and same-shaped paragraphs before swapping vocabulary. These are editorial heuristics, not proof of authorship or a prediction of any detector's score.

## Preserve meaning before style

A tell is a pattern, not an isolated word or punctuation mark. Approved voice guidance and deliberate choices outrank this catalogue. Preserve factual claims, attribution, uncertainty, negation, comparisons, rankings, and the author's intended asks. Never add an ask, deadline, personal experience, number, or opinion to make a draft sound more human.

Keep code, commands, identifiers, product names, legal text, quotations, and terminology under discussion verbatim. A suspected factual problem belongs in the report: an unsourced claim is not necessarily false. Correct or remove a claim only when supplied evidence or the user's instruction supports the change, and disclose it. Otherwise preserve it and flag verification; do not present the draft as ready to publish.

Severity maps to action:

| Severity | Meaning | Action |
|---|---|---|
| **CRITICAL (P0)** | Credibility killer. Reader loses trust. | Resolve explicitly; preserve and report unresolved claims. |
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

Workflow:

```
0. Auto-detect channel + voice target
1. Voice calibration (conditional)
2. Pattern scan (structural → credibility → vocab → positive → context)
3. Severity gate (patch vs. full rewrite; clean-but-hollow check)
4. Rewrite at chosen depth
5. Self-audit (mandatory long-form; conditional short-form)
6. Emit final draft + humanizer report
```

### Step 0 — Auto-detect channel

Infer channel silently from cues (greeting/salutation, file path, word count, hashtags, code fences, voice cues). See `references/channels.md` → Auto-Detect Cues. Default to `generic long-form` if ambiguous and note the assumption in the final report. Don't ask unless two or more channels are genuinely plausible.

### Step 1 — Voice calibration

Resolve the voice before scanning. Use the user's instructions for this draft first, then the approved guide or sample for whoever will publish it, then applicable upstream voice instructions, and finally the draft's existing voice. A personal profile does not govern a brand asset just because that person wrote it. Within the selected voice, explicit preferences outrank inferred habits. Ask only when conflicting sources would materially change the edit.

Read `references/voice-calibration.md` when a sample or profile is supplied, the user requests voice matching, or upstream voice rules apply. Capture six observations: sentence rhythm, word choice, paragraph openings, punctuation, recurring phrasing, and transitions. Cite short sample spans or guide sections; mark weak evidence instead of inventing precise rates from a tiny sample.

Apply this to writing as a person even when it contains no first-person pronouns. Use a supplied profile in its existing format; do not require conversion to Humanizer's template. If a requested source cannot be read, say so. For an ordinary scrub, continue conservatively in the draft's voice; for an explicit voice match, request the missing source before claiming a match.

Calibration is transient. Do not save a profile or change configuration unless the user asks. With no source, skip profiling and preserve what is there.

### Step 2 — Pattern scan

Fixed order — structural tells are load-bearing; vocab tells are surface. **Read `references/patterns.md` before scanning.**

1. **Dramatic reframe + punchline structures** (patterns §3.1, §3.2) — the highest-signal tells
2. **Structural patterns** (§3.3 through §3.16)
3. **Credibility** (§2): flag unsupported attribution and preserve real uncertainty; never substitute invented evidence.
4. **Vocabulary tiers** (§4)
5. **Positive checks** — is there a point of view, a concrete detail, an earned opener?
6. **Context checks** — punctuation budgets (§6), banned openers (§7), register-appropriate forms

Tally hits. Group vocab hits by category — category count feeds Step 3.

### Step 3 — Severity gate

**Patch vs. full rewrite.** Trigger full rewrite if all three are true (per `references/patterns.md` §1):
- 5+ Tier 1/Tier 2 vocab hits
- 3+ distinct pattern categories triggered
- Uniform sentence length — three-plus consecutive sentences within 2 words of each other

**Structure can trigger a rewrite on its own.** If cadence and paragraph shape are uniform across the piece (`references/patterns.md` §3.3) and the repetition weakens the reading experience, go to full rewrite even when the vocab is clean and no other category fired. Patching smooths the surface; it does not add the structural variance a uniform draft is missing.

Otherwise patch mode. Surgical edits only, leave the rest alone. Numeric thresholds are review cues, not mechanical commands: short messages, procedures, deliberate parallelism, and approved voice can justify regular rhythm.

**Clean-but-hollow flag.** If the draft passes the scan but says nothing — no concrete claim, no specific example, no defensible point of view — flag `[HOLLOW]` explicitly. A clean-style draft with no substance is still broken.

### Step 4 — Rewrite

Produce the rewrite at the depth Step 3 chose. Preserve the writer's voice and argument. The humanizer removes tells; it does not impose a house style on a draft that already has one.

Fix structure before vocabulary. First give each sentence room for its job: a claim may need detail; a pivot may be short. Then cut filler within that shape. Never pad to meet a word-count target or flatten every sentence to the same length. Preserve useful details and mixed feelings already present; add specificity only from supplied evidence, with its attribution intact.

In patch mode, change only affected spans, but return the complete corrected draft under both output headers. In full mode, rebuild structure while preserving meaning. If substance is missing, report the gap; editing cannot supply the author's experience or evidence.

### Step 5 — Self-audit (mandatory second pass)

The load-bearing step of the pipeline. Do not skip on long-form.

**Mandatory for:** blog posts, case studies, sales collateral, newsletters, LinkedIn posts, any external email >4 sentences, any draft that triggered full rewrite in Step 3.

**Conditional for:** Slack messages, short internal emails, CTAs, subject lines — skip **only if** Step 2 flagged nothing.

Audit the candidate and report concise findings:

1. What residual patterns weaken this draft? Inspect structure as well as vocabulary, without assuming the text must contain a tell.
2. Did any fact, name, number, date, quotation, citation, ranking, qualification, negation, or ask change? Restore accidental changes. Report any evidence-backed correction separately.
3. Does the edit still match the selected voice, including its deliberate exceptions? Restore voice flattened by generic rules.

Revise against those findings. If nothing remains, say so with a brief reason. When a short clean draft skips the audit, say "Skipped: short draft with no findings" under Self-Audit. This is an editorial check, not an authorship verdict.

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

"What patterns remain, and were meaning and voice preserved?"

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

In Rewrite mode, preserve the supported content in Final Version and mark the missing substance in the report. Do not invent it or insert a publishable-looking placeholder. State that the draft needs author input before publication. See `references/channels.md` → Per-Channel Hollow Failure Modes for what counts as hollow per channel.

### Nothing Flagged

If the draft is clean: `## Issues Found` = `- None detected.`, Rewritten Draft = original, Self-Audit follows Step 5, Final Version emitted verbatim. **Emit all section headers even on a clean pass** — downstream agents parse by header. Detect mode is the one exception; it does not emit `## Final Version`.

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
    a) Em dashes: unrestricted, reduced (default: max 1 / 500 words), or banned?
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

To use it, tell your agent:
  Humanize this draft using the voice profile at <path>.

To edit later, open the file or ask to update the profile.
```

Humanizer is a Markdown skill, not a CLI. Flags and environment variables only work if the host integration explicitly implements them. Use a path or pasted profile as the portable interface.

**Re-running setup.** If the profile already exists, update only the requested sections. Ask for missing information instead of inventing it. Replace the whole profile only when the user explicitly requests replacement.

**Brand profile after author profile.** When Q1 = "Both", run the same interview a second time with brand framing.

**Don't ask** the user to enumerate the universal Tier 1 vocab list, structural patterns, or punctuation budgets — those are built in. Setup only captures what varies per user/brand.

---

## Worked mini-example

Input: "We're leveraging the new workflow to streamline onboarding. It's been transformative for the team."

Edit: "We're using the new workflow to make onboarding faster. It's made a big difference to the team."

Report: The edit keeps the author's qualitative claims, without verifying them. `[HOLLOW]`: the workflow and the result are unspecified; ask the author for an example before publication. Do not replace "transformative" with an invented day saved per hire.

See `examples/before-after-*.md` for complete examples and `examples/voice-calibration.md` for sample-based calibration.

## Sources

The inherited pattern catalogue and its historical attributions are documented in `ATTRIBUTION.md`. The voice-precedence and claim-preservation additions adapt Michael Lock's September 2026 deslop work. Thresholds are editorial defaults, not validated detection rates. No detector-evasion benchmark is claimed.

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
- **Don't polish toward uniformity.** Preserve natural variation where it serves meaning. Deliberate repetition and consistent procedure steps can be useful.
- **Don't reach for gimmicks.** Forced typos, invisible characters, or arbitrary punctuation do not improve the writing. Do not promise detector evasion.
- **Don't fabricate replacements.** Flag an unsupported claim for verification; never manufacture evidence, silently delete information, or turn uncertainty into certainty.
- **Don't rewrite past the user's intent.** If the piece is meant to be punchy (ad headline, stop-scroll caption, subject line), the structural rules loosen. Judgment over mechanical application.
- **Don't silently approve a hollow draft.** A draft that passes every tell but says nothing specific is still broken. Flag `[HOLLOW]` and let the user decide.
- **Don't decline the task; escalate instead.** If a full rewrite would require replacing >80% of the words, the draft is a ghost-write request, not a humanizing task. Return it with a note rather than fabricating new content.
