---
name: ai-slop-correction
description: Identify and correct AI-generated writing patterns in academic computer science papers. Targets sentence uniformity, overused vocabulary (delve, underscore, pivotal, etc.), excessive hedging, formulaic transitions, em-dash overuse, bullet-point-with-bold patterns, excessive parenthesized text, and structural predictability. Use when reviewing or editing thesis text, especially after AI-assisted writing or when detectors flag content.
license: MIT
compatibility: opencode
metadata:
  author: manuel
  version: "1.0"
---

# AI Slop Detection and Correction for Academic CS Papers

## Purpose

This skill identifies and corrects AI-generated writing patterns in academic computer science papers. It targets the linguistic markers that AI detectors flag: sentence uniformity, overused vocabulary, excessive hedging, formulaic transitions, and structural predictability.

**Scope:** English-language academic writing in computer science (papers, theses, dissertations). Not for creative writing, marketing, or casual prose.

**Goal:** Make AI-assisted text read like human academic writing while preserving technical accuracy and rigor.

---

## When to Use This Skill

- After generating or heavily editing text with AI assistance
- When AI detectors flag your writing as "likely AI-generated"
- When text feels formulaic, repetitive, or lacks your authentic voice
- Before submitting papers, theses, or dissertations
- When reviewers comment that writing feels "generic" or "templated"

---

## Detection Patterns

### 1. Sentence-Level Patterns

#### 1.1 Low Burstiness (Sentence Length Uniformity)

**What to look for:**
- Average sentence length clusters tightly around 20-30 words
- Standard deviation of sentence lengths is low (< 8 words)
- Few very short sentences (< 10 words) or very long sentences (> 35 words)
- Paragraphs feel rhythmically monotonous

**Human baseline:**
- Average: 23.2 words (academic prose)
- Short sentences (< 10 words): ~5.8% of total
- Mix of short (3-8), medium (12-20), and long (25-35+) sentences within paragraphs

**AI pattern:**
- Average: 29.2 words
- Short sentences: ~2.4% of total
- Sentences cluster in 16-25 word range

**Example from detector output:**
> "The project is expected to advance the state of the art in multi-language static analysis through three main contributions."

This 20-word sentence is typical AI length. A human might write: "This project advances multi-language static analysis. We make three contributions." (14 words total, more punchy)

#### 1.2 Uniform Sentence Openers

**What to look for:**
- Multiple sentences in a row start with "This...", "The...", "Furthermore,", "Moreover,"
- Paragraphs lack variety in how sentences begin
- Predictable rhythm: subject-verb-object repeated

**AI pattern:**
```
This approach achieves X. This method improves Y. This framework extends Z.
```

**Human pattern:**
```
Our approach achieves X. Performance improves on Y by 15%. We extend the framework to handle Z.
```

#### 1.3 Syntactic Complexity Uniformity

**What to look for:**
- All sentences have similar grammatical structure
- No variation between simple, compound, and complex sentences
- Missing: parenthetical asides, rhetorical questions, sentence fragments for emphasis

**Correction:** Within each paragraph, include:
- One simple sentence (subject-verb-object)
- One sentence with a subordinate clause
- One sentence with a semicolon or coordinating conjunction
- One sentence with a parenthetical or aside

---

### 2. Word-Level Patterns

#### 2.1 The "Focal Words" — LLM-Overused Vocabulary

These words appear 3-10x more frequently in AI-generated academic text than in human writing. **Flag any occurrence; reduce density to < 1 per 500 words.**

**High-confidence AI markers:**

| Word | Frequency Increase | Replacement Strategy |
|------|-------------------|---------------------|
| `delve` | +1,360% to +1,582% | Use "examine", "investigate", "analyze" |
| `underscore` | +1,000% to +10,000% | Use "emphasize", "highlight", "show" |
| `intricate` | +700% to +5,400% | Use "complex", "detailed", "nuanced" (but see below) |
| `showcasing` | +10.2× excess | Use "demonstrating", "showing", "illustrating" |
| `pivotal` | Sharp surge from 2023 | Use "important", "key", "critical" |
| `realm` | Sudden surge from 2023 | Use "domain", "area", "field" |
| `meticulous` | +2,800% | Use "careful", "thorough", "detailed" |
| `nuanced` | Sharp increase | Use "subtle", "complex", "detailed" |
| `surpass` | Overrepresented | Use "exceed", "outperform", "beat" |
| `comprehensive` | +4.5pp excess | Use "complete", "full", "thorough" |
| `findings` | +3.1pp excess | Use "results", "data", "observations" |
| `crucial` | +2.9pp excess | Use "important", "key", "essential" |
| `significant` | +99% in CS abstracts | Use "large", "substantial", "notable" |
| `additionally` | Continued growth | Use "also", "furthermore" (sparingly), or restructure |

**arXiv CS-specific markers (from 2.4M abstracts analysis):**
- `via` — increased noticeably in titles from 2025
- `beyond` — favored by newer models

#### 2.2 Inflated Adjectives and Hype Language

**Flag and replace:**

| AI Phrase | Problem | Human Alternative |
|-----------|---------|-------------------|
| "state-of-the-art" | Overused, vague | "best published results", "current best", or cite specific baseline |
| "novel" | Claims originality without proof | "new", "previously unpublished", or describe what's new |
| "innovative" | Hype word | Describe the innovation specifically |
| "robust" | Overused in CS | "stable", "reliable", "resilient to X" |
| "rigorous" | Self-praise | Let the proof/methodology speak for itself |
| "transformative" | Marketing language | Describe the impact specifically |
| "seamless" | Marketing language | "integrated", "unified", "automatic" |
| "comprehensive" | Filler modifier | "complete", "full", or remove |

#### 2.3 Flowery Metaphors

**Remove or replace:**

| AI Metaphor | Human Alternative |
|-------------|-------------------|
| "in the realm of X" | "in X", "for X", "in the X domain" |
| "the landscape of X" | "X", "current X research" |
| "the tapestry of X" | "X", "the X ecosystem" |
| "the fabric of X" | "X", "X structure" |
| "embark on a journey" | "begin", "start", "undertake" |
| "navigate the complexities" | "handle", "address", "manage" |

#### 2.4 Function Word Distribution

**AI pattern:**
- Higher frequency of: `of`, `the` (nominal density)
- Lower frequency of: `is`, `are`, pronouns (I, we, they), auxiliary verbs

**Human pattern:**
- More pronouns: "we", "our", "they"
- More auxiliary verbs: "can", "will", "have"
- Less nominalization

**Correction:**
```
AI: "The implementation of the algorithm was performed by the system."
Human: "We implemented the algorithm in the system."
```

#### 2.5 Hedging Language Overuse

**What to look for:**
- Multiple hedges stacked in one sentence
- Hedging where certainty is warranted
- Hedge phrases that add no information

**Common AI hedge clusters:**
```
"could potentially possibly be argued that..."
"it may be worth considering that..."
"this might suggest that there could be..."
"it is important to note that..."
```

**Correction — Hedge Collapse:**
```
BEFORE: "It is important to note that these results could potentially suggest 
that there may be a correlation between the two variables."
AFTER: "These results suggest a correlation between the two variables."
```

**When hedging is appropriate:**
- Genuinely uncertain claims
- Speculative interpretations
- Limitations section

**When to remove hedging:**
- Established facts
- Your own results
- Proven theorems

---

### 3. Structural Patterns

#### 3.1 The Four-Part AI Sentence DNA

**AI default structure (found in 82% of AI-generated text):**

1. **Opening** — Framing claim or landscape statement
   - "In recent years, the field of X has seen significant advances..."
2. **Expansion** — Elaboration or supporting evidence
3. **Contrast** — Reframe or tension signal
   - "However, it is not just about..."
4. **Resolution** — Takeaway or call to action
   - "Ultimately, X is what matters most"

**Correction:** Break this structure deliberately.
- Remove opening landscape sentences entirely
- Start paragraphs with specific claims, not framing
- End paragraphs without neat wrap-up
- Leave tension unresolved sometimes

#### 3.2 Paragraph Length Uniformity

**What to look for:**
- All paragraphs are 4-6 sentences
- Paragraphs are roughly equal length
- No short (2-3 sentence) or long (7-8 sentence) paragraphs

**Correction:** Vary paragraph length based on content:
- Short paragraphs for emphasis or transitions
- Long paragraphs for detailed explanations
- Let content dictate length, not pattern

#### 3.3 Framework-Heavy Organization

**What to look for:**
- Excessive numbered lists
- Explicit transitions: "First... Second... Third..."
- Visible structural scaffolding

**Correction:**
```
AI: "There are three reasons for this. First, X. Second, Y. Third, Z."
Human: "X explains part of this. Y also matters because... Finally, Z..."
```

Use explicit enumeration only when clarity genuinely requires it.

#### 3.4 Em-Dash Overuse

**What to look for:**
- Multiple em-dashes (—) or double hyphens (--) in a paragraph
- Em-dashes used for parenthetical asides instead of commas or parentheses
- Em-dashes used to connect clauses that could be separate sentences
- Pattern: "The main issue — and this is critical — is that..."

**Why it flags:**
AI disproportionately favors em-dashes for dramatic emphasis and clause connection. Human academic writing uses them sparingly, preferring commas, semicolons, or separate sentences.

**AI pattern:**
```
"The framework — which extends prior work on abstract interpretation — 
achieves significant improvements. The key insight — that ownership can 
be tracked parametrically — enables precise analysis."
```

**Context-aware replacement — choose based on the em dash's function:**

| Function | Example | Best replacement |
|----------|---------|-----------------|
| Clarification / restatement | "X — that is, Y — Z" | `i.e.,` with commas: "X, i.e., Y, Z" |
| Example | "X — for instance, Y — Z" | `e.g.,` with commas: "X, e.g., Y, Z" |
| Parenthetical aside | "X — which matters because Y — Z" | Commas or parentheses: "X (which matters because Y) Z" |
| Contrast | "X — but Y — so Z" | Semicolons or separate sentences |
| Appositive | "X — a parametric domain — Z" | Commas: "X, a parametric domain, Z" |
| Dramatic emphasis | "X — and this is critical — Y" | Separate sentence: "X. This is critical: Y." |
| Enumeration / list intro | "Three tools — A, B, and C — exist" | Colon: "Three tools: A, B, and C exist" or restructure |

**Examples of context-specific replacement:**

```
// Em dash for clarification → i.e.
BEFORE: "The analysis is sound — it never reports false negatives — but may be imprecise."
AFTER:  "The analysis is sound, i.e., it never reports false negatives, but may be imprecise."

// Em dash for example → e.g.
BEFORE: "Several tools — ROSA, flowR, fastR — address related problems."
AFTER:  "Several tools (e.g., ROSA, flowR, fastR) address related problems."

// Em dash for contrast → separate sentences
BEFORE: "The domain is parametric — however, the element domain must be fixed before use."
AFTER:  "The domain is parametric. However, the element domain must be fixed before use."

// Em dash for appositive → commas
BEFORE: "μR — a minimal core calculus — captures the essential vector operations."
AFTER:  "μR, a minimal core calculus, captures the essential vector operations."
```

**Correction:**
- Identify the semantic function of each em dash (clarification, example, aside, contrast, appositive, emphasis)
- Choose the replacement accordingly: `i.e.`, `e.g.`, commas, parentheses, semicolons, colon, or separate sentence
- Keep at most 1 em dash per 1000 words
- Use em dashes only for genuine dramatic emphasis, not routine clause connection

#### 3.5 Bullet Points with Bold Text

**What to look for:**
- Excessive use of bulleted or numbered lists
- Every bullet point starts with bold text followed by a colon
- Lists used where prose would be more natural
- Pattern:
  ```
  - **First contribution:** Description of first contribution.
  - **Second contribution:** Description of second contribution.
  - **Third contribution:** Description of third contribution.
  ```

**Why it flags:**
AI defaults to enumerated lists with bold headers as a way to appear organized. Human academic writing uses lists sparingly, typically only for:
- True enumerations (algorithm steps, theorem conditions)
- Comparison tables
- When clarity genuinely requires visual separation

**AI pattern:**
```
Our contributions are:
- **A formal framework:** We develop a unified intermediate representation 
  for multi-language analysis.
- **Sound abstract domains:** We design domains for ownership, pointer, and 
  aliasing analysis.
- **Rigorous proofs:** We prove soundness theorems for all abstract operators.
```

**Human alternatives:**

Option 1 (prose):
```
We make three contributions. First, we develop a formal framework with a 
unified intermediate representation for multi-language analysis. Second, we 
design sound abstract domains for ownership, pointer, and aliasing analysis. 
Third, we prove soundness theorems for all abstract operators.
```

Option 2 (minimal list):
```
Our contributions are: (1) a formal framework with a unified intermediate 
representation, (2) sound abstract domains for ownership and aliasing analysis, 
and (3) soundness proofs for all abstract operators.
```

**Correction:**
- Convert bullet lists to prose when possible
- If a list is necessary, use inline enumeration: (1), (2), (3)
- Reserve bulleted lists for: algorithm steps, theorem conditions, or true comparisons
- Avoid bold-colon pattern in lists
- Maximum 1 bulleted list per page in academic prose

#### 3.6 Excessive Parenthesized Text

**What to look for:**
- Multiple parenthetical asides in a single sentence
- Long parenthetical phrases (10+ words)
- Parentheses used for information that should be in the main sentence or a footnote
- Pattern: "The framework (which extends prior work) achieves improvements (see Table 1) across benchmarks (including DaCapo and SPEC)."

**Why it flags:**
AI overuses parentheses to pack additional information into sentences without committing to separate sentences. This creates dense, hard-to-parse prose. Human writers either:
- Integrate the information into the main sentence
- Use separate sentences
- Move supplementary information to footnotes

**AI pattern:**
```
"The abstract domain (parameterized by a set of attributes) captures ownership 
information (including must-alias and may-alias relations) while maintaining 
precision (comparable to state-of-the-art tools)."
```

**Human alternatives:**

Option 1 (integrate):
```
"The abstract domain is parameterized by a set of attributes and captures 
ownership information, including must-alias and may-alias relations. It 
maintains precision comparable to state-of-the-art tools."
```

Option 2 (separate sentences):
```
"The abstract domain is parameterized by a set of attributes. It captures 
ownership information, including must-alias and may-alias relations. Precision 
is comparable to state-of-the-art tools."
```

Option 3 (footnotes for citations/data):
```
"The abstract domain is parameterized by a set of attributes and captures 
ownership information.¹ It maintains precision comparable to state-of-the-art 
tools.²"
```

**Correction:**
- Maximum 1 parenthetical per sentence
- Keep parenthetical phrases short (< 8 words)
- Integrate important information into the main sentence
- Move supplementary information to footnotes or separate sentences
- Use parentheses only for: citations, brief clarifications, or technical notation

---

### 4. Common AI Phrases in Academic CS Writing

#### 4.1 Abstract-Level Markers

**Flag these constructions:**
- "In this paper, we present a novel..."
- "We propose a comprehensive..."
- "Our approach achieves state-of-the-art performance on..."
- "Extensive experiments demonstrate..."
- "To the best of our knowledge..."
- "This work addresses the problem of..."

**Human alternatives:**
```
AI: "In this paper, we present a novel framework for X."
Human: "We introduce X, a framework for..."

AI: "Our approach achieves state-of-the-art performance on CIFAR-10."
Human: "On CIFAR-10, our approach achieves 97.3% accuracy, outperforming 
the prior best result by 1.2 percentage points."
```

#### 4.2 Introduction-Level Markers

**Flag these:**
- "In recent years, the field of [X] has seen significant attention..."
- "Despite the remarkable progress, several challenges remain..."
- "To address these limitations, we propose..."
- "Our main contributions are summarized as follows:"
- "The rest of this paper is organized as follows:"

**Human alternatives:**
```
AI: "In recent years, machine learning has seen remarkable progress in NLP."
Human: "Transformer models now achieve near-human performance on most NLP 
benchmarks."

AI: "Despite remarkable progress, several challenges remain."
Human: "Three challenges persist."
```

#### 4.3 Toxic Phrases (Ultra-High AI Signal)

**These constructions, when they co-occur, are extremely strong AI indicators:**

| Phrase | Why It Flags | Replacement |
|--------|-------------|-------------|
| "a comprehensive overview" | AI loves "comprehensive" | "an overview", "a survey" |
| "a wide range of" | Vague quantification | "many", "several", or list them |
| "it is worth noting that" | Hedge + filler | Remove entirely or state directly |
| "in the context of" | Framing scaffold | "for", "in", "when" |
| "with respect to" | Formal padding | "for", "about", "regarding" |
| "as well as" | Inflated "and" | "and" |
| "in order to" | Inflated "to" | "to" |
| "due to the fact that" | Inflated "because" | "because" |
| "has the ability to" | Inflated "can" | "can" |
| "a number of" | Vague | "several", "many", or specific count |
| "various aspects of" | Vague placeholder | List the aspects |
| "multiple factors" | Vague placeholder | List the factors |
| "it is important to note that" | Pure filler | Remove or state directly |

---

### 5. Transition Phrase Density

**What to look for:**
- Multiple transition words in one paragraph: "furthermore", "moreover", "additionally", "however", "therefore"
- Every sentence starts with a transition
- Transitions that add no logical information

**Human baseline:**
- ~1 transition per paragraph (not per sentence)
- Prefer implicit logical flow over explicit markers

**Correction:**
```
AI: "Furthermore, X. Moreover, Y. Additionally, Z. However, W."
Human: "X. Y also matters. Z extends this. W presents a challenge."
```

**Replace formal connectors with specific logical moves:**
- "Furthermore," → "Building on this," or "This also applies to..."
- "Moreover," → "A related issue is..." or "This matters because..."
- "However," → "The contrast is..." or "But..."
- "In addition," → "This also..." or restructure
- "Therefore," → "This follows from..." or "We conclude..."

---

## Correction Workflow

### Step 1: Diagnose Before Editing

**Mark each paragraph as:**
- **Evidence-dense** (citations, data, methodology) — leave alone
- **Analytical** (interpretation, discussion) — focus here
- **Transitional** (introductions, conclusions) — focus here

**Priority order:**
1. Abstract and introduction (most visible)
2. Conclusion and future work
3. Discussion and interpretation
4. Methodology (only if it reads formulaically)

### Step 2: Cut, Do Not Rephrase

**The single strongest move is removing words.** AI over-explains.

**Remove:**
- Opening landscape sentences ("In recent years...")
- Hedged restatements ("It is important to note that...")
- Generic conclusions ("In summary, we have presented...")
- Sentences that don't add information

**Target:** 10-20% word count reduction in analytical sections.

### Step 3: Add Evidence, Not Refinement

**Replace abstract claims with concrete references:**

```
AI: "Many studies have shown that X improves Y."
Human: "Smith et al. (2023) showed X improves Y by 15%."

AI: "Our approach achieves better performance."
Human: "On CIFAR-10, our approach achieves 97.3% accuracy, outperforming 
the prior best by 1.2pp."
```

### Step 4: Remove AI-Tell Patterns

**Systematically remove or reduce:**
- Em-dashes: replace with commas, parentheses, or separate sentences (max 1 per 1000 words)
- Bullet lists with bold headers: convert to prose or inline enumeration (1), (2), (3)
- Excessive parentheses: max 1 per sentence, keep short (< 8 words), integrate important info into main sentence
- Semicolons (split into two sentences)
- "furthermore", "moreover", "thus" (replace with specific logic)
- Cleft constructions: "It is important to note that..."
- Causal sentence fusion: "X, because Y" → restructure
- Crisp metaphor verbs: "delve", "leverage", "navigate"
- Inflated adjectives: "pivotal", "seamless", "transformative"
- Flowery metaphors: "tapestry", "realm", "landscape"

### Step 5: Introduce Burstiness

**Force sentence length variation:**
- After every 3-4 sentences of similar length, insert one very short sentence (3-8 words)
- Follow with one noticeably longer sentence (35+ words)
- Target distribution: short (< 12 words) = ~20%, medium (12-25) = ~50%, long (> 25) = ~30%

**Vary sentence structure:**
- Mix simple, compound, and complex sentences
- Add parenthetical asides
- Use rhetorical questions sparingly
- Permit controlled inconsistency

**Vary paragraph length:**
- Some paragraphs: 2-3 sentences (emphasis)
- Some paragraphs: 6-8 sentences (detailed explanation)
- Let content dictate length

### Step 6: Verify, Then Stop

**Detector variance is ±10-20 points.** If three rewrites land within 15 points of each other, ship the best.

**The most common mistake is over-refinement.** Further polishing often makes text *more* AI-like, not less.

**Stop when:**
- Detector scores stabilize (±15 points across rewrites)
- Text reads naturally to you
- Technical accuracy is preserved
- Your authentic voice is present

---

## The One-Paragraph Method

**For each paragraph, ensure:**

1. **Sentence lengths:** Mix of short (3-8 words), medium (12-20), and long (25-35)
2. **Sentence openers:** No two consecutive sentences start the same way
3. **Transition strategy:** No more than one explicit transition per paragraph; prefer implicit logical flow
4. **Specificity:** At least one named entity, citation, or concrete example
5. **Hedging:** At most one hedge phrase, and only if genuine uncertainty exists
6. **Closing:** Either end without a summary sentence, or end with a specific implication (not a generic wrap-up)

**Example application:**

```
AI VERSION (flagged):
"In recent years, the field of static analysis has seen significant advances. 
Furthermore, recent approaches have leverages sophisticated type systems to 
achieve more precise results. Moreover, these methods have demonstrated 
robust performance across a wide range of benchmarks. However, several 
challenges remain in scaling these techniques to large codebases."

HUMAN VERSION (corrected):
"Static analysis has matured considerably. Modern type systems enable 
precision that was impractical a decade ago. On the DaCapo benchmark suite, 
recent tools achieve 85-92% accuracy across 15 programs. Scaling to 
codebases exceeding 1M LOC remains open."
```

**Changes made:**
- Removed opening landscape sentence
- Reduced sentence count from 4 to 4 (but varied lengths: 6, 11, 16, 10 words)
- Removed "furthermore", "moreover", "however"
- Replaced "leveraged" with "enable"
- Replaced "wide range of benchmarks" with specific "DaCapo benchmark suite"
- Added concrete numbers: "85-92% accuracy", "15 programs", "1M LOC"
- Removed hedging: "have demonstrated" → "achieve"
- Ended with specific challenge, not generic "challenges remain"

---

## Quick Reference Checklist

**Before submitting, check:**

- [ ] Sentence length variation: short (< 10 words), medium (12-25), long (> 30)
- [ ] No two consecutive sentences start the same way
- [ ] Focal word density: < 1 per 500 words (delve, underscore, intricate, etc.)
- [ ] No inflated adjectives: pivotal, seamless, transformative, comprehensive, rigorous
- [ ] No flowery metaphors: realm, landscape, tapestry, fabric, journey
- [ ] Transition density: < 1 explicit transition per paragraph
- [ ] Hedge density: < 1 hedge phrase per paragraph (unless genuine uncertainty)
- [ ] Paragraph length variation: mix of 2-3 sentence and 6-8 sentence paragraphs
- [ ] Em-dash density: max 1 per 1000 words (prefer commas, parentheses, or separate sentences)
- [ ] Bullet lists: convert to prose or inline enumeration; max 1 bulleted list per page
- [ ] Parentheses: max 1 per sentence, keep short (< 8 words), integrate important info into main sentence
- [ ] Concrete evidence: citations, numbers, specific examples in analytical sections
- [ ] Active voice for claims, passive for methodology
- [ ] No opening landscape sentences ("In recent years...")
- [ ] No generic conclusions ("In summary, we have presented...")
- [ ] Text reads naturally when read aloud

---

## Examples from Your Detector Output

**Example 1: Sentence length**
```
DETECTED: "The project is expected to advance the state of the art in 
multi-language static analysis through three main contributions." (20 words)

CORRECTED: "This project advances multi-language static analysis. We make 
three contributions." (14 words, more direct)
```

**Example 2: Function word density**
```
DETECTED: High function word density (40% vs AI 33%)

This is actually good — your text has human-like function word usage. 
Maintain this by using pronouns ("we", "our") and auxiliary verbs ("can", 
"will") naturally.
```

**Example 3: Short sentence presence**
```
DETECTED: "Presence of very short sentences strengthens the human pattern 
(human 5.8% vs AI 2.4%)"

Your text has good short sentence presence. Continue using concise clauses 
to break up longer sentences.
```

---

## Limitations and Caveats

**Detectors are imperfect:**
- False positives: Corporate prose, legal memos, and highly formal academic writing can trip detectors even when human-written
- False negatives: Emerging LLMs (diffusion-based models) evade detection
- Short text (< 300 words) is unreliable
- Hybrid text (human + AI) is hardest to detect

**This skill is a guide, not a guarantee:**
- Detector variance is ±10-20 points
- No rewrite technique guarantees passing all detectors
- The goal is authentic human voice, not detector evasion
- Technical accuracy always takes priority over style

**When to ignore this skill:**
- Methodology sections that require formal, precise language
- Mathematical proofs and formal definitions
- Direct quotations from sources
- Sections where formality is genre-appropriate (e.g., related work surveys)

---

## Thesis Project Tools

If working within the master-thesis repo, the following pre-approved script
replaces ad-hoc `grep`/`sed`/`awk` for checking all detection patterns
listed in this skill:

```
~/.config/opencode/scripts/prose-stats <file>                       # full report (JSON)
~/.config/opencode/scripts/prose-stats <file> --forbidden            # thesis forbidden words
~/.config/opencode/scripts/prose-stats <file> --find <word>          # search a specific word
~/.config/opencode/scripts/prose-stats <file> --context <word>       # with context
~/.config/opencode/scripts/prose-stats <file> --format latex         # for .bib/.tex files
```

Use `--find` to check individual words from the vocabulary lists below.
Use `--context` to examine surrounding prose. Use `--format latex` when
checking `.bib` or `.tex` files (strips `%` comments).
Default output is JSON — add `--human` for the color-coded table.

## Additional Resources

**Key research:**
- Juzek & Ward (COLING 2025): 21 focal words in scientific abstracts
- Liang et al. (2024): 35% of arXiv CS abstracts are ChatGPT-style
- Bloomberry AI Writing Patterns Database: 4,628 vocabulary phrases
- Boucher et al. (2025): Comprehensive detector benchmark

**Detection tools:**
- GPTZero
- Originality.ai
- Turnitin AI Detection
- Copyleaks
- Winston AI

**Use these to validate your corrections, but don't optimize solely for detector scores.**
