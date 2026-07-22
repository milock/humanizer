# Pattern Reference

The full AI-tell catalog. Loaded on demand by the Humanizer skill during Step 2 of the pipeline (Pattern Scan). Organized by severity tier from credibility killers down to stylistic drag.

Scan order matters: structural tells (§3) before vocabulary (§4) before context checks (§6, §7). Most of the AI-tell signal is structural; vocabulary fixes are necessary but rarely sufficient.

---

## 1. Full-Rewrite Threshold

Trigger full rewrite when **all three** are true:
- 5+ Tier 1/Tier 2 vocab hits (see §4)
- 3+ distinct pattern categories triggered
- Uniform sentence length — three-plus consecutive sentences within 2 words of each other

Otherwise patch mode. Patching only smooths the surface; the skeleton is still AI-shaped if the threshold is hit.

---

## 2. CRITICAL Patterns (P0) — Credibility Killers

These lose the reader's trust in one sentence. Always fix. No judgment call.

| Pattern | What it is | Fix |
|---|---|---|
| **Fabricated stats / fake specificity** | Precise-sounding numbers with no real source ("studies show 73% of teams..."). | Cut, or replace with a real cited figure. Never approximate to sound authoritative. |
| **Fake attributions** | Quotes or claims attributed to an expert/study that doesn't exist or doesn't say that. | Verify the source says the exact thing. If not, cut. |
| **Knowledge-cutoff disclaimers** | "As of my last update..." / "I may not have the latest..." | Delete entirely. |
| **Chatbot artifacts** | "Let me know if you'd like me to expand...", "I hope this helps!", "Happy to revise." | Delete. Never ships in final copy. |
| **Sycophancy** | "Great question!", "That's a fantastic point..." | Delete. |

**BEFORE (fabricated stats):** "Studies show that 73% of B2B teams lose revenue to onboarding friction, with most seeing a 12% hit to deal velocity annually."
**AFTER:** "In the teams we've worked with, onboarding friction typically costs 3–8% of pipeline velocity — not catastrophic, but meaningful at scale." (Cites experience over invented precision.)

**BEFORE (chatbot artifact at end of email):** "Let me know if you'd like me to expand on any of this, or if you'd prefer I tighten it further!"
**AFTER:** (Delete entirely. Sign off cleanly with the writer's actual close.)

---

## 3. HIGH Patterns (P1) — Structural AI Tells

The high-signal structural tells. In rough order of severity:

### 3.1 Dramatic Reframe — the #1 AI tell
"That's not X. That's Y." — where Y adds no new information, just relabels X for effect.

- **BEFORE:** "This isn't a hiring problem. This is a process problem."
- **AFTER:** "The hiring gap is downstream of the process — fix the intake handoff and the headcount math changes."

Variant: **Definition reframes** — "It's an execution problem dressed up as a strategy problem." Same mechanic, same fix: say the actual thing.

### 3.2 Manufactured Punchline / Bumper-Sticker Closer
Section or piece ends on a tidy aphorism that sounds quotable but doesn't say anything. Includes **orphan closers** (one-line dramatic endings) and **section-ending zingers**.

- **BEFORE:** "Because in customer success, the details aren't details. They're everything."
- **AFTER:** "Miss the kickoff agenda and renewal probability drops 15 points. That's most of the variance between a 90% and 105% net retention number."

### 3.3 Cadence & Structural Regularity — the #1 detector signal
Uniform rhythm is the strongest signal a statistical classifier keys on, and the one a polishing pass most often makes worse. Two layers:

**Sentence cadence (burstiness).** Human writing swings between short, medium, and long sentences; AI and over-polished prose cluster near one length. Flag when three-plus consecutive sentences land within 2 words of each other, or when most of the piece sits inside a single 15–25-word band. Target a visibly mixed distribution — some sentences under 8 words, some over 30. Read-aloud test: if it scans like a metronome, it is too regular.

**Paragraph shape.** Evenly-sized paragraphs (nearly every one 3–4 sentences of similar length) read as machine-built. Vary it — let a one-line paragraph sit next to a dense one.

Rule of thumb: **no three consecutive same-length sentences, and no long run of same-shape paragraphs.** Fix this by *increasing* variance, never by evening the rhythm out. This is the highest-signal structural tell in the catalog — check it on every pass, and treat a uniform-cadence draft as a full-rewrite trigger (§1) even when the vocabulary is already clean.

### 3.4 Performative Directness
"Here's the truth." / "Let's be real." / "The reality is..." — throat-clearing dressed as candor.

- **BEFORE:** "Here's the deal. Most vendors don't actually understand the workflow."
- **AFTER:** "Most vendors don't actually understand the workflow."

### 3.5 Dramatic Fragment Q&A
"Pricing? Undisclosed." / "The catch? There isn't one." Question-plus-fragment answer. Cut or convert to a full sentence.

### 3.6 Runway Sentences
Vague hype sentence that exists only to set up the real sentence that follows.

- **BEFORE:** "The stakes have never been higher. Companies are facing unprecedented pressure on margins."
- **AFTER:** "Companies are facing margin pressure — pricing power is flat while labor costs are up double digits since 2021."

### 3.7 Persuasive Authority Tropes
"The real question is...", "At its core...", "Fundamentally...", "What this really means is...". Authority-by-assertion with no earned authority behind it. Delete and state the thing.

### 3.8 Tailing Negations / Negative Parallelism
"No guessing. No wasted motion. No hand-offs that fall apart." Three-or-more negations tacked onto a claim. Reads like landing-page copy from any vendor.

- **BEFORE:** "We take over the migration. No handoffs. No dropped data. No surprises."
- **AFTER:** "We take over the migration on day one. The previous vendor's unfinished work is ours to close."

### 3.9 Elegant Variation / Synonym Cycling
The same thing named four different ways to avoid repetition — "the customer / the client / the partner / the organization". Readers notice. Pick one noun and repeat it.

### 3.10 Copula Avoidance
"Acme serves as the platform..." / "The product stands as a single source of truth..." Use *is/are*. "Acme is the platform." That's all the sentence needed.

### 3.11 Inspirational Pivot
Ends on uplift that wasn't earned by the preceding text. Usually starts with "But here's the thing..." or "The good news is...". Cut the pivot — if the argument earns an uplift, the reader reaches it on their own.

### 3.12 Vulnerability Performance
"I'll be honest..." / "Can I be real for a second?" / "Not gonna lie..." Performative candor as a credibility grab. Delete and say the honest thing directly.

### 3.13 Anaphora / Repetitive Negation
"Not the vendor. Not the timeline. Not the scope." Three-plus parallel openers with the same word. One is rhythm. Three is AI.

### 3.14 Universal Authority Without Source
"Industry experts agree...", "Studies show...", "It's well known that..." — no citation. Either add the source or cut the claim.

### 3.15 Fragmented Headers
Heading followed by a one-line restatement of the heading before the real content starts.

- **BEFORE:** `### The transition is fast` followed by "Our transitions are fast. Here's why:"
- **AFTER:** `### The transition is fast` followed by "Most customers are fully on the new system within three to six weeks..."

### 3.16 Credential-Stacking / Stat-Bomb / Tension-Colon Openers
Opening patterns to avoid:
- **Credential stack:** "As a marketing leader who's run campaigns for five years at three companies..."
- **Stat bomb:** "73% of teams lose revenue to churn. Most don't know it."
- **Tension colon:** "The dirty secret of the industry: vendors don't actually want you to leave."
- **Common-belief-then-counter:** "Everyone says switching vendors is risky. It isn't."

All of these signal "blog post written by AI." Open on a number tied to a specific situation, a named person or company, or a specific observation instead — "Lisa's team cut deployment time from four hours to twenty minutes" beats any of the four openers above.

---

## 4. Vocabulary — 3-Tier System

**Domain-terminology exemption:** Industry-specific metrics, technical codes, regulatory terms, and legal language are exempt from Tier 2/3 density checks. "Significant" in a clinical finding, "crucial" in a compliance clause, or "critical" in an incident report are precise, not filler. Apply the tiers to general prose only — not to technical claims, quoted regulations, or domain vocabulary the audience will read as load-bearing.

### Tier 1 — Always Replace (5–20x more common in AI than human writing)

delve, pivotal, multifaceted, myriad, plethora, robust, seamless, leverage, unlock, unleash, harness, empower, embark, realm, landscape (metaphorical), tapestry, beacon, illuminate, bolster, meticulous, elevate, streamline, groundbreaking, transformative, unprecedented, game-changer

No judgment call. Cut or swap every time.

### Tier 2 — Flag in Clusters (2+ in same paragraph)

foster, facilitate, nuanced, crucial, cornerstone, paramount, burgeoning, navigate (metaphorical), journey (metaphorical), vital, critical, holistic, cutting-edge, comprehensive, ecosystem

One of these in a paragraph: fine. Two or more: rewrite the paragraph — the AI tell is the density, not any single word.

### Tier 3 — Flag at Density (~3%+ of content words)

significant, innovative, effective, dynamic, scalable, compelling, exceptional, sophisticated, strategic, impactful, meaningful, valuable, essential, key (as adjective)

These are real English words. Only flag when the draft leans on them as a crutch — if three+ appear in 100 words, the draft has no specific nouns to stand on.

### Filler Qualifiers — Always Cut

arguably, notably, importantly, essentially, fundamentally, truly, really, very, simply, just (as softener), quite, rather, somewhat

Exceptions: "just" meaning "only/recently" ("we just launched"). "really" in quoted dialogue.

---

## 5. MEDIUM Patterns (P2) — Stylistic Drag

| Pattern | Fix |
|---|---|
| **Compulsive tricolons** | Three-item lists everywhere. Break pattern — use twos and fours. |
| **Present participle stacking** | "Helping teams, driving revenue, improving outcomes" → convert to verbs. |
| **Em dashes as default punctuation** | See §6 budget. |
| **Premature lists** | Bullets before the idea is developed in prose. Write prose first; bullet only if the list is truly list-shaped. |
| **Colon-heavy titles** | "The Onboarding Revolution: Why Teams Need a New Playbook". Pick one clause. |
| **Only 2nd/3rd person voice** | Vary — use "we" when it's a first-party claim. |
| **Puffing up importance** | "It's critical that..." / "Now more than ever..." Delete the puff. |
| **Generic/vanilla tone** | No specific numbers, names, or examples. Add one concrete detail per paragraph. |
| **Hyphenated word-pair over-consistency** | "data-driven, outcomes-focused, customer-centered" stacked. Pick one. |
| **Superficial -ing analyses** | "By focusing on X, teams can achieve Y" — vague cause-effect. Name the mechanism. |
| **Arrow chains** | "Research → draft → review → publish". Fine once; tic if repeated. |
| **Period-separated word emphasis** | "Calm. Specific. Human." Fine rarely; tic if used more than once per piece. |
| **One-line paragraphs throughout** | LinkedIn-style formatting. OK for LinkedIn; not for blog/email. |
| **Inline-header vertical lists / boldface overuse** | Every third phrase bolded. Bold only what a scanner truly needs. |
| **Fake humility / engagement-bait closers** | "What am I missing?" / "Am I wrong?" — only keep if the question is real. |
| **Rhetorical throat-clearing** | "Let's talk about...", "Now, about X..." Start on the thing. |
| **False ranges** | "From startups to enterprises, from solo founders to large companies" when the two ends aren't on a meaningful scale. Pick the specific audience. |

---

## 6. Quantified Punctuation Budgets

Hard caps per piece. Going over one is usually a sign of an unearned rhythm.

| Mark | Budget | Notes |
|---|---|---|
| Em dash (—) | **Max 1 per 500 words** | Some authors prefer zero — if a voice profile bans them, swap for hyphens with spaces or commas. |
| Exclamation point | **Max 1 per 1,000 words** | External content only. Avoid in 1:1 emails unless register is explicitly enthusiastic. |
| Ellipsis (…) | **Max 1 per piece** | Usually delete entirely. |
| Semicolon | **Max 2 per 500 words** | Rare in natural speech. |
| Rhetorical question | **Max 1 per 500 words** | More than that and the piece sounds like a monologue pretending to be a conversation. |

---

## 7. Banned Openers (Hard Cuts)

Never ship a piece that opens with:
- "In today's [anything] landscape/world/era..."
- "In an era of..."
- "Now more than ever..."
- "In the world of..."
- "When it comes to..."
- "Whether you're X or Y..."

If you find one, cut the opener and start on the second paragraph — 90% of the time it's the real opener.
