# Typst Styling Knowledge: Math Mode, Paragraphs, Blocks, and Tables

> Consolidated research from Typst docs, GitHub issues, and community discussions.
> Compiled for the master-thesis project (Typst thesis on abstract interpretation).

---

## 1. Display vs. Inline Math

### 1.1 The Space Rule

Typst uses the **presence or absence of whitespace** around the `$` delimiters to decide math mode:

| Syntax | Mode | Behavior |
|---|---|---|
| `$x^2$` | **Inline** | Rendered within the text flow, same baseline as surrounding text. No paragraph break. |
| `$ x^2 $` | **Display (block)** | Rendered as a centered block on its own line. Creates a paragraph break. |
| `$ x^2$` or `$x^2 $` | **Undefined** | Inconsistent spacing — avoid. Typst will warn or produce unexpected results. |

> **Source:** [Typst Math Reference](https://typst.app/docs/reference/math/) — "They will be typeset into their own block if they start and end with at least one space."

The rule is **syntactic** (parsing-time), not a styling choice. Even a single space on each side triggers display mode:

```typst
// Inline
Let $a$, $b$, $c$ be sides of a triangle.

// Display
$ a^2 + b^2 = c^2 $
```

### 1.2 The `math.equation` Element

Under the hood, both forms create a `math.equation` element. The `block` field controls the mode:

| `block` parameter | Effect |
|---|---|
| `false` (default) | Inline equation, flows with text |
| `true` | Block/display equation, centered on its own line |

You can create equations explicitly:

```typst
#math.equation(block: false, $x^2 + y^2 = z^2$)   // inline
#math.equation(block: true, $x^2 + y^2 = z^2$)    // display
```

You can also change the default with `#set`:

```typst
#set math.equation(block: true)   // all math becomes display
```

> **Source:** [Typst math.equation docs](https://typst.app/docs/reference/math/equation/)

### 1.3 Forcing Display Style in Inline Math

The `math.display()` and `math.inline()` functions control the **size style** (not the block/inline mode):

```typst
// Inline math, but with display-mode sizing (larger fractions, sums, etc.)
$ f(x) = display(sum_(i=0)^n x_i) $

// Display math, but with inline-mode sizing
$ inline(sum_(i=0)^n x_i) $
```

- `math.display()`: Forces display-style sizing (normal size for block equations)
- `math.inline()`: Forces inline-style sizing (smaller, fits text flow)
- `math.script()` / `math.sscript()`: Smaller sizes for sub/superscripts

> **Source:** [Typst math.sizes docs](https://typst.app/docs/reference/math/sizes/)

### 1.4 The Problem with `cases()` in Inline Math

The `cases()` function renders all branches at their natural size. In **inline** math mode, all symbols are typeset at inline size, which makes delimiters like braces scale to the (smaller) inline content height.

```typst
// Small brace — inline mode makes everything smaller:
$ cases(1 "if" x > 0, -1 "if" x < 0) $

// Properly sized brace — display mode uses display sizing:
$ cases(1 "if" x > 0, -1 "if" x < 0) $
```

The fix is either:
- Use display math `$ ... $` (with spaces) to get proper sizing, **or**
- Use `math.display()` inside inline math to force display sizing:
  ```typst
  $ display(cases(1 "if" x > 0, -1 "if" x < 0)) $
  ```

> **Source:** [Typst cases docs](https://typst.app/docs/reference/math/cases/)

---

## 2. Paragraph Formation Rules

### 2.1 What Becomes a Paragraph

From the [Typst par docs](https://typst.app/docs/reference/model/par/#what-becomes-a-paragraph):

**Inline-level content** (text, horizontal spacing, boxes, inline equations) is **automatically collected into paragraphs** by Typst.

**Paragraph breaks** are created by:
- A **blank line** in the source (or explicit `#parbreak()`)
- Any **block-level element** (like `block`, `place`, display math, etc.)

**Inside a container** (like `block`): Text is only wrapped in a paragraph **if the container holds any block-level content**. If all contents are inline-level, no paragraph is created.

### 2.2 Practical Consequences

- `set par(first-line-indent: ...)` only applies to **proper paragraphs**, not bare inline content inside a container.
- `show par: ...` rules only trigger on proper paragraphs.
- Block-level elements **interrupt paragraphs**. This means display math (`$ ... $`) will break the current paragraph.

### 2.3 Inline vs. Block-Level Elements

| Category | Elements |
|---|---|
| **Inline-level** | Text, `#box(...)`, inline math (`$x^2$`), `#h(...)`, `#v(...)` (in some cases) |
| **Block-level** | `#block(...)`, `#place(...)`, display math (`$ x^2 $`), `#table(...)`, `#grid(...)`, headings, lists, figures |

The `#box()` function can be used to **embed block-level content inline**:

```typst
// Make a block-level table flow inline
This is #box[#table(columns: 2, [a], [b])] inside a paragraph.
```

> **Source:** [Typst box docs](https://typst.app/docs/reference/layout/box/) — "All elements except inline math, text, and boxes are block-level and cannot occur inside of a paragraph."

---

## 3. The `#block` Function

### 3.1 Purpose

`block` is a **block-level container** used to group content, control sizing, and add backgrounds/borders. Because it is block-level, it **interrupts the current paragraph**.

> **Source:** [Typst block docs](https://typst.app/docs/reference/layout/block/)

### 3.2 Key Parameters

| Parameter | Type | Default | Purpose |
|---|---|---|---|
| `width` | `auto` / relative | `auto` | Block width. Use `100%` to fill available width. |
| `height` | `auto` / relative / fraction | `auto` | Block height (breakable across pages if larger than remaining space) |
| `breakable` | `bool` | `true` | Whether the block can split across pages |
| `fill` | color / gradient / etc. | `none` | Background color |
| `stroke` | stroke | `none` | Border |
| `radius` | relative / dict | `none` | Corner rounding |
| `inset` / `outset` | relative / dict | `none` | Internal padding / external expansion |
| `spacing` | relative / fraction | `1.2em` | Space around block (shorthand for `above` + `below`) |
| `above` / `below` | auto / relative | `auto` | Space before/after block |
| `sticky` | `bool` | `false` | Prevent page break between this block and the next |

### 3.3 Alignment Control with `block`

**`block` does not have a direct alignment parameter.** To center a block's content, you have two options:

**Option A:** Use `align()` inside the block:

```typst
#block(width: 100%)[
  #align(center)[
    $ a^2 + b^2 = c^2 $
  ]
]
```

**Option B:** Use `set align()` before the block:

```typst
#set align(center)
#block(width: 60%, fill: silver)[
  $ a^2 + b^2 = c^2 $
]
```

**Option C:** Use block in show rules to adjust display math spacing:

```typst
#show math.equation: set block(above: 8pt, below: 16pt)
```

### 3.4 Common Patterns with `block`

**Making display math fill available width (e.g., in narrow containers):**

```typst
#show math.equation.where(block: true): eq => block(width: 100%, eq)
```

**Making a block unbreakable while preserving alignment (from forum):**
```typst
#block(breakable: false, width: 100%)[
  Some text and $ display math $
]
```
Without `width: 100%`, the block shrinks to fit its content, and centered math inside it still appears centered *within the block* — but the block itself may be smaller than the container, making it look off-center. Setting `width: 100%` forces the block to fill the container, so center alignment works as expected.

**Wrapping display math in a block to control alignment inside tables:**

```typst
#table(
  columns: 2,
  [#block(width: 100%, align(center, $ cases(...) $))],
  [regular text cell],
)
```

This is the pattern used to solve the "cases brace too small in inline math" problem while controlling the center alignment that display math auto-applies.

> **Source:** [Typst block docs](https://typst.app/docs/reference/layout/block/) + Typst Forum discussions

---

## 4. Tables and Math Alignment

### 4.1 Table Alignment Basics

Tables accept an `align` parameter that can be:

1. **A single alignment** (applied to all cells): `align: center + horizon`
2. **An array** (cycled per column): `align: (left, center, right)`
3. **A function** `(x, y) => alignment`: `align: (x, y) => if x == 0 { left } else { right }`

Example:

```typst
#table(
  columns: (1fr, 2fr),
  align: (left, center),
  [Name], [Description],
  [Foo], [$ a^2 + b^2 $],
)
```

> **Source:** [Typst table docs](https://typst.app/docs/reference/model/table/) and [Table Guide](https://typst.app/docs/guides/tables/)

### 4.2 Per-Cell Alignment

Use `table.cell(align: ...)` to override alignment for a specific cell:

```typst
#table(
  columns: 2,
  [Left-aligned text],
  table.cell(align: center + horizon)[$ x^2 $],
)
```

### 4.3 Alignment Priority

From GitHub issue [#4766](https://github.com/typst/typst/issues/4766):

The priority order is:
1. `set table.cell(align: ...)` (per-cell override — highest)
2. `set table(align: ...)` (table-wide)
3. `set align(...)` (global — lowest, only used if no override)

Note: Per-cell alignment always overrides alignment from "outside." A `set table(align: ...)` inside a table cell scope has no effect (there's no table inside the cell).

### 4.4 Inline Content vs. Block Content in Table Cells

This is **critical for understanding math behavior in tables**:

- **Inline content** (text, `$x^2$`, `#box(...)`) flows naturally and aligns according to the cell's alignment setting.
- **Block content** (display math `$ x^2 $`, `#block(...)`, `#table(...)`) interrupts the paragraph inside the cell and may affect alignment differently.

Display math inside a table cell **auto-centers** itself. To control this:
- Wrap display math in `#block(width: 100%)` to fill the cell width, then control alignment inside the block.
- Or use `align()` explicitly: `#align(left, $ cases(...) $)`

### 4.5 Table Math Alignment Issues (Community Findings)

- **Issue [#5489](https://github.com/typst/typst/issues/5489):** Matrices in table cells can cause unexpected line breaks due to the presence of Unicode control characters (`\u{2066}` / `\u{2069}`) wrapping the content. The line segmenter incorrectly treats these as line break opportunities, causing blank lines to appear.
- **Forum thread:** Display equations in tables align baselines differently from inline math — inline math matches text baseline, while display math has its own block-level baseline.
- **Workaround for baseline alignment:** If you need consistent baseline alignment of math across table cells, prefer inline math (`$x^2$`) for simple expressions and only use display math (`$ x^2 $`) when you need display-mode features (like properly sized `cases()` braces).

---

## 5. The `#box` Function (Inline Container)

### 5.1 Purpose

`box` is an **inline-level container**. Unlike `block` (block-level), `box` stays within the text flow and can appear inside a paragraph.

> **Source:** [Typst box docs](https://typst.app/docs/reference/layout/box/)

### 5.2 Key Differences from `block`

| Feature | `box` | `block` |
|---|---|---|
| Level | **Inline** (stays in paragraph) | **Block** (breaks paragraph) |
| Width | Can use `1fr` for fractional sizing | Accepts `auto` / fixed values |
| Fractional width | ✅ Unique to boxes | ❌ |
| Page breaking | N/A (inline) | Can be made breakable/unbreakable |
| Use case | Wrapping inline content, adding padding around inline math | Separating content blocks, backgrounds, centering |

### 5.3 Box with Math

Since `box` is inline-level, it's useful for adding space around inline math:

```typst
#lorem(17) #box($display(1)/display(1+x^n)$, inset: 0.2em) #lorem(20)
```

You can also use `box` with fractional width inside paragraphs (unique to boxes):

```typst
#box(width: 1fr, $a^2 + b^2 = c^2$)   // fills remaining paragraph width
```

---

## 6. Best Practices for Math in Tables

### 6.1 Rule of Thumb

| Situation | Recommendation |
|---|---|
| Simple variable reference | Inline math `$x$` — fits text flow, aligns by baseline |
| Fraction, sum, integral in table cell | Inline math with `display()` if needed: `$ display(sum_i x_i) $` |
| `cases()`, `mat()`, multi-line expressions | Display math `$ ... $` with `#block(width: 100%)` to control alignment |
| Mixed text and math in one cell | Inline math for short expressions embedded in text |
| Table header with math | Inline math (consistent baseline with header text) |

### 6.2 Pattern: Display Math in Tables with Alignment Control

When you need display math (e.g., `cases()` with proper brace sizing) inside a table cell and want to control alignment:

```typst
#table(
  columns: 2,
  align: (left, center),
  [Label],
  table.cell(
    align: center + horizon,
    block(width: 100%)[
      $ cases(
        1 "if" x > 0,
        -1 "if" x < 0,
      ) $
    ],
  ),
)
```

Or more concisely, when you just need to prevent center-alignment of display math:

```typst
// Display math in a table cell, left-aligned
#table(
  columns: 2,
  [Left cell],
  #align(left, block(width: 100%)[
    $ cases(...) $
  ]),
)
```

### 6.3 Pattern: Using `math.display()` to Avoid Display Math

When you need display-mode sizing but want to stay inline (to avoid block-level centering):

```typst
// Inline math with display-style sizing — stays inline
$ display(cases(1 "if" x > 0, -1 "if" x < 0)) $
```

This works in table cells without creating a paragraph break:

```typst
#table(
  columns: 2,
  [$ display(cases(1 "if" x > 0, -1 "if" x < 0)) $],
  [regular text],
)
```

### 6.4 Pattern: Forcing Display Math to Use Cell Alignment

If you need display math but want it to obey the cell's alignment (e.g., left-aligned):

```typst
#table(
  columns: 2,
  align: (left, left),   // cell wants left alignment
  [Label],
  #align(left, block(width: 100%)[
    $ a^2 + b^2 = c^2 $
  ]),
)
```

The `block(width: 100%)` is crucial — without it, the block shrinks to fit the math, and the `align(left, ...)` has no visible effect because the block is already as wide as its content.

### 6.5 Pattern: Preventing Page Breaks Inside Math-Heavy Table Cells

```typst
#set table.cell(breakable: false)
```

This prevents individual cells from splitting across pages. However, if you need to wrap the cell's body in additional block-level elements (e.g., for borders), be aware that this can break cell alignment — you'd need to re-apply `align(it.align, it)`.

> **Source:** [GitHub issue #5793](https://github.com/typst/typst/issues/5793)

---

## 7. Complete Reference: Math Mode Cheat Sheet

### 7.1 Choosing Math Mode

```typst
// Inline math (no spaces around $ delimiters)
//   - Stays in text flow
//   - Uses inline sizing (smaller fractions, sums, etc.)
//   - Works naturally in table cells
$x^2 + y^2 = z^2$

// Display math (spaces around $ delimiters)
//   - Centered on its own line
//   - Uses display sizing (properly scaled braces, sums, etc.)
//   - Creates a paragraph break
//   - Auto-centers (use #block to override)
$ x^2 + y^2 = z^2 $

// Explicit control via math.equation
#math.equation(block: false, $x^2 + y^2 = z^2$)
#math.equation(block: true, $x^2 + y^2 = z^2$)

// Global default change
#set math.equation(block: true)
```

### 7.2 Math Sizing Functions

```typst
$ display(sum_i x_i) $     // Force display size inside any mode
$ inline(sum_i x_i) $      // Force inline size
$ script(x) $              // Script size (like superscript)
$ sscript(x) $             // Second script size
```

### 7.3 Container Comparison

| Function | Level | Use Case |
|---|---|---|
| `box()` | Inline | Padding around inline math, fractional widths in paragraphs |
| `block()` | Block | Centering display math, backgrounds, page-break control |
| `align()` | Block (by default) | Horizontal/vertical alignment of block content |
| `table.cell()` | Cell-level | Per-cell alignment override in tables |

### 7.4 Error-Prone Patterns (Avoid)

```typst
// ❌ Inconsistent spacing — ambiguous mode
$ x^2$   // warning: opening has space, closing doesn't

// ❌ Display math without width control in table cell
#table(columns: 1, [$ cases(...) $])
// → Display math centers itself; cell alignment may not apply as expected

// ❌ block without width: 100% inside align
#align(left, block[$ a^2 + b^2 $])
// → block shrinks to fit content; no visible left-alignment change

// ✅ Correct version
#align(left, block(width: 100%)[$ a^2 + b^2 $])
```

---

## 8. Source Index

| Topic | Source | URL |
|---|---|---|
| Math mode syntax | Typst Math Reference | https://typst.app/docs/reference/math/ |
| `math.equation` element | Typst Docs | https://typst.app/docs/reference/math/equation/ |
| Math sizing (`display`, `inline`, etc.) | Typst Docs | https://typst.app/docs/reference/math/sizes/ |
| `cases()` function | Typst Docs | https://typst.app/docs/reference/math/cases/ |
| Paragraph formation | Typst Docs | https://typst.app/docs/reference/model/par/#what-becomes-a-paragraph |
| `block` function | Typst Docs | https://typst.app/docs/reference/layout/block/ |
| `box` function | Typst Docs | https://typst.app/docs/reference/layout/box/ |
| `align` function | Typst Docs | https://typst.app/docs/reference/layout/align/ |
| `table` function | Typst Docs | https://typst.app/docs/reference/model/table/ |
| Table guide | Typst Docs | https://typst.app/docs/guides/tables/ |
| Table alignment priority | GitHub Issue #4766 | https://github.com/typst/typst/issues/4766 |
| Matrices breaking in tables | GitHub Issue #5489 | https://github.com/typst/typst/issues/5489 |
| Table cell body selection | GitHub Issue #5793 | https://github.com/typst/typst/issues/5793 |
| Show math.equation breaks alignment | GitHub Issue #3973 | https://github.com/typst/typst/issues/3973 |
| Inline math with spaces question | Typst Forum | https://forum.typst.app/t/on-writing-inline-math-like-this-with-the-spaces/7740 |
| Display math block width issue | Typst Forum | https://forum.typst.app/t/how-to-make-a-block-with-math-not-breakable-while-keeping-center-alignment/7418 |
| Examples book: Math | Community resource | https://sitandr.github.io/typst-examples-book/book/basics/math/index.html |
