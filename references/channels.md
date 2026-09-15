# Channel Profiles & Voice Reference

Loaded on demand by the Humanizer skill during Step 0 (Auto-detect channel) and Step 1 (Voice calibration). Different channels tolerate different patterns — a one-line paragraph is normal in Slack and flagged in a blog post. This file holds the strictness rules, the auto-detect cues, the per-channel hollow-failure modes, and the voice carve-outs.

---

## Auto-Detect Cues

Strongest cue wins. If two cues point to different channels, ask rather than guess.

| Cue | Channel |
|---|---|
| `Hi [Name],` / `Hello,` / sign-off block / subject line | Email |
| `<@U…>` mentions, `:emoji:`, `#channel`, thread-style | Slack |
| <300 words + hashtags, or arrow chains | LinkedIn |
| First-person "I", personal anecdote | LinkedIn — personal |
| "We're building" / organizational cues without "I ran" | LinkedIn — organizational |
| Code fences, H2/H3 headers, >800 words, "we" voice | Blog post |
| Pull-quote blocks, before/after metrics, customer named | Case study |
| Editorial register, recurring section structure | Newsletter |
| Bulleted list + `@name` owner tags, no prose intro | Meeting agenda |
| Headline + subhead + <100 words + CTA language | Landing page / ad |
| `r/` prefix, "OP", anonymous first-person | Reddit reply |
| "Feedback:" / "When you did X, I noticed Y" | Feedback note |
| Marketing merge tags (`{{first_name}}`), promo CTA | Marketing email |

---

## Channel × Strictness Matrix

Approved voice and instructions for this draft outrank every default in this table. Do not infer a required pronoun or persona from the channel alone.

**S** = strict (flag), **R** = relaxed (house style — don't flag), **I** = format convention (subject to the request), **N** = normal.

| Channel | One-line paras | Staccato | "We" voice | First-person "I" | Voice profile to load |
|---|---|---|---|---|---|
| Newsletter (editorial) | R | R | N | R | brand or author |
| Blog post / case study | S | S | N | N | brand |
| Marketing email | N | N | N | N | brand |
| Email (1:1) | N | N | N | R | author |
| LinkedIn — personal | R | R | N | R | author |
| LinkedIn — organizational | R | R | N | R | brand |
| Slack (team or 1:1) | R | R | N | R | author |
| Meeting agenda | I (bullets) | N | N | N | none (format rules apply) |
| Feedback / coaching note | R | R | N | R | author |
| Landing page / ad | R | R | N | N | brand |
| Reddit reply | R | R | N | R | none (anonymous register) |

---

## Per-Channel Hollow Failure Modes

Assess substance against the draft's purpose. These are diagnostic cues, not required ingredients: a notification need not contain an ask, a useful qualitative example need not contain a number, and an agenda may legitimately include time estimates. Flag `[HOLLOW]` when missing information prevents the piece from doing its job:

| Channel | Hollow failure mode |
|---|---|
| Blog / newsletter | No specific numbers, no named source, no operational detail — sounds smart, says nothing |
| Case study | No quantified before/after, no customer name, no direct quote |
| Email (1:1 or marketing) | Ask is buried past line 3, multiple asks stacked, or no ask when one is expected |
| LinkedIn — personal | Opinion without a concrete example or number — "take" without teeth |
| LinkedIn — organizational | Predicts audience pain instead of reporting what was observed; generic platitude |
| Slack — team | Over-explains context before the ask; ask buried |
| Slack — 1:1 (terse register) | More than 2 sentences of preamble before the point |
| Meeting agenda | Decisions or actions whose owners are unclear |
| Landing page / ad | No specific proof point (stat, customer, outcome) above the fold |
| Feedback note | Abstract ("be more proactive") without the specific behavior + moment |
| Reddit reply | Generic hot-take without a specific counter-point or personal experience; reads like it was written without reading the thread |

---

## When to Ask vs. Decide

Infer the channel from the request and the strongest cues. Ask only when two plausible channels or audiences would materially change the edit. With weak cues and no consequential conflict, preserve the draft's register and note the assumption instead of requiring an interview.

---

## Author Voice — Configurable Carve-Outs

Some patterns look AI-ish in isolation but are part of an author's actual voice. **When an author voice profile is loaded, do not flag these patterns unless combined with other tells:**

- **Short sentences (intentionally punchy).** Example: "We lost the deal. She knew before I did." Leave it if the author writes that way.
- **Occasional sentence fragments.** Example: "Tough call, but the right one." Leave it.
- **Starting sentences with "And" or "But."** Example: "And the results were better than we expected." / "But that's not the only issue." Leave them.
- **One-line paragraphs** in Slack, internal memos, and personal LinkedIn — not in client-facing brand voice. Example from a LinkedIn post: "It took us three tries to get the pricing right." — on its own line — is a natural cadence for many writers.
- **Hyphens with spaces** instead of em dashes, if the author or brand profile specifies it.
- **Specific terms of address or honorifics** the audience expects (titled professionals, formal salutations) — load these from the voice profile.

The test is whether the pattern serves the intended voice and audience. Approved brand exceptions also outrank the matrix. Use the matrix only where no applicable voice guidance decides the issue.

If no voice profile is loaded, treat the patterns above as low-priority — flag only when stacked with other tells.

For evidence-based calibration, read `references/voice-calibration.md`. Preserve code and expected results in procedures; do not rewrite regular instructions merely to vary cadence.
