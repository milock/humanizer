# Voice Profiles

Voice profiles are how Humanizer learns to leave your voice alone. They're optional — the skill works with zero configuration — but a populated profile is the difference between "scrubs AI tells without flattening you" and "scrubs AI tells, sometimes flattens you."

This doc explains what makes a voice profile actually change the output, and what doesn't.

---

## What a voice profile is

A short markdown file. Any path. The skill reads it when invoked and uses it for two things:

1. **Step 1 — Voice calibration.** It captures sentence-length distribution, register, recurring phrases, and quirks. The rewrite preserves these.
2. **§8 — Author voice carve-outs.** Patterns that look AI-ish in isolation but are part of your actual voice get an exception. They only flag when stacked with other tells.

There are two flavors:

- **Author voice profile** — first-person writing. Emails, Slack, LinkedIn (personal), internal memos, feedback notes.
- **Brand voice profile** — organizational/client-facing writing. Blog, case studies, landing pages, marketing emails, LinkedIn (org).

You can have one, both, or neither. The skill selects the publisher's voice using the request and audience, not pronouns alone. Explicit instructions outrank inferred sample habits. Existing profile formats work without conversion.

Templates: [`examples/author-voice.example.md`](../examples/author-voice.example.md), [`examples/brand-voice.example.md`](../examples/brand-voice.example.md).

---

## What actually changes the output

Voice profile content varies in usefulness. Some sections do real work; others are decorative.

### High-leverage (these change the rewrite)

- **Sample paragraphs** of your real writing. Three short ones is plenty. The skill reads register, sentence-length distribution, paragraph openers, and punctuation habits from these — while explicit instructions establish your preferred style. **If you only fill in one section, fill in this one.**
- **Hard nos.** Phrases or tropes you never want. The skill treats these as additions to the universal banned list (§7). Be specific — "never use 'in today's [anything]'" is operational; "be authentic" isn't.
- **Quirks to preserve.** Patterns the skill should not flag. The defaults in §8 cover common ones (sentence fragments, "And"/"But" starts, one-line paragraphs in casual channels). List anything additional that's specific to you.
- **Punctuation preferences.** Em dash defaults to "max 1 per 500 words"; if you ban them entirely, say so.
- **Domain vocabulary.** Industry-specific words where Tier 2/3 terms are precise rather than filler. "Critical" in an incident report is precise; "critical" in marketing copy is filler. Listing your domain stops false-positive flags.

### Medium-leverage (helpful but not load-bearing)

- **Required language.** "Always say 'customers,' never 'users'" — useful for brand profiles, less so for personal voice.
- **Channel-specific overrides.** Most defaults work; only override what genuinely differs.
- **Strategic alignment notes** (brand only). A list of operational facts your content must align with. Catches the failure mode where the writing is technically clean but contradicts how you actually operate.

### Low-leverage (skip unless you really care)

- **Self-description of your "register"** ("warm and conversational"). Too broad to resolve many line-level choices without examples. Use samples as evidence of habits, while honoring explicit instructions about the desired register.
- **Lists of writers/brands you admire.** Doesn't translate to detectable patterns.
- **Mood adjectives** ("approachable yet authoritative"). Decorative.

---

## How to write samples that actually calibrate

Three short real samples beat one long fabricated one.

**Good:**
- 3 paragraphs from emails you've actually sent (different recipients/contexts is ideal)
- 1 LinkedIn post you wrote and shipped
- 1 short Slack message you wrote in your normal register

**Less good:**
- Long polished writing from a different register than the one you're profiling
- Things you wish you wrote that way — the skill needs the actual baseline
- AI-generated text you "made sound like you" — defeats the purpose

If you don't have anything written down, paste a transcript of yourself talking about a work topic for 60 seconds. Label it as spoken language; its rhythm may not transfer to written prose.

---

## When NOT to load a voice profile

- **Anonymous register** (Reddit replies, anonymous forums). Use only a profile appropriate to the requested anonymous register.
- **Technical/regulatory content.** Preserve code, legal text, and precise terms. Apply a relevant voice guide only to surrounding prose.
- **One-shot drafts in someone else's voice** (writing as a colleague, ghostwriting). Use a one-time sample paste instead — Step 1 in the skill walks through this.

---

## Where to keep profile files

Up to you. Common patterns:

- `~/.humanizer/author-voice.md` (user-wide, works across all projects)
- `./voice/author.md` (project-scoped, e.g., for a content team's shared brand voice)
- Inside an existing personal-context folder (`context/me.md`, `personal/voice.md`, etc.)

If you use Claude Code with a `CLAUDE.md` in the project, reference the profile there so it auto-loads:

```markdown
## Voice
- For first-person drafts, load `voice/author.md` and pass it to the humanizer skill.
- For brand drafts, load `voice/brand.md`.
```

---

## Updating profiles over time

Profiles aren't static. If the skill flags the same pattern three times across drafts and you keep saying "stet, that's intentional," the skill will surface it at the end:

> "You've kept [pattern] in 3+ drafts. Want me to add it to your voice profile?"

That's the cue to update §8 (author carve-outs) of your profile so the skill stops flagging it. Same for words that should be exempt from Tier 2/3 density checks — add them to the "domain vocabulary" section.

If your role/audience changes substantially, ask Humanizer to replace the profile using new samples and preferences.

---

## Templates

- [Author voice profile template](../examples/author-voice.example.md)
- [Brand voice profile template](../examples/brand-voice.example.md)

## Calibration in v1.2

Use `Humanize this draft using the voice profile at <path>` or paste a sample. The six-dimension calibration and post-edit comparison live in [references/voice-calibration.md](../references/voice-calibration.md). Calibration stays within the current task unless you request a saved profile. Missing samples yield stated preferences, not fabricated measurements.
