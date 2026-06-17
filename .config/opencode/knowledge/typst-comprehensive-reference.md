# Typst Comprehensive Reference for AI Agents

> This file consolidates Typst documentation examples, project-specific knowledge, and common patterns.
> **Read this file before writing any Typst code.**

---

## Part 1: Typst Language Fundamentals

### 1.1 The Three Modes

Typst has three syntactical modes that interleave:

| Mode | Syntax | Example |
|---|---|---|
| **Markup** | Default in document body | `*bold*`, `_italic_`, `= Heading` |
| **Code** | Prefix with `#` | `#let x = 1`, `#if cond { .. }` |
| **Math** | Surround with `$..$` | `$x^2$`, `$sum_(i=0)^n i$` |

**Mode transitions:**
```typst
// Markup → Code: use #
Number: #(1 + 2)

// Markup → Math: use $..$
Inline: $x^2$
Display: $ x^2 $    // spaces at boundaries = display mode

// Code → Content: use [..]
#let name = [*Typst!*]

// Math → Code: use # inside $..$
$ #rect(width: 1cm) $
```

### 1.2 Markup Mode Syntax

```typst
= Heading               // 1st-level heading
== Subheading           // 2nd-level heading
=== Sub-subheading      // 3rd-level heading

*strong*                // bold
_emphasis_              // italic

- item                  // bullet list
+ item                  // numbered list
/ Term: description     // description list

`print(1)`              // inline code (raw text)
https://typst.app/      // auto-link

<label-name>            // label
@label-name             // reference

Blank line              // paragraph break
\                       // explicit line break
~                       // non-breaking space
---                     // em dash
```

### 1.3 Code Mode Syntax

```typst
#let x = 1                          // variable
#let f(x) = x * 2                   // function
#if x == 1 { .. } else { .. }       // conditional
#for val in (1,2,3) { .. }          // loop
#while x < 10 { .. }                // while
#set page(margin: 2cm)              // set rule
#show heading: it => ..             // show rule
#context text.lang                  // context expression
#include "file.typ"                 // include module
#import "file.typ": func            // import from module
```

**Comments:**
```typst
// Line comment
/* Block comment */
```

**Escape sequences:**
```typst
\#  \\  \$  \_  \*  \[  \]  \(  \)
\u{1f600}    // Unicode codepoint
```

### 1.4 Math Mode Syntax

**Inline vs display:**
```typst
$inline$     // no spaces = inline
$ display $  // spaces = display (centered block)
```

**Math elements:**
```typst
$x_1$                    // subscript
$x^2$                    // superscript
$(a+b)/5$                // auto-fraction
$frac(a, b)$             // explicit fraction
$x \ y$                  // line break
$x &= 2 \ &= 3$          // aligned equations

$->$  $<=$  $>=$         // symbol shorthands
$alpha$, $beta$, $pi$    // Greek letters
$Sigma$, $Omega$         // uppercase Greek

$floor(x)$               // math function (no # needed)
$#rect(width: 1cm)$      // non-math function (needs #)
$a "is natural"$         // text in math

$arrow.l.squiggly$       // symbol variants
$x y$                    // implied multiplication

$vec(x_1, x_2, x_3)$     // vector
$mat(1, 2; 3, 4)$        // matrix (; separates rows)
$cases(1 "if" x>0, 2)$   // cases/piecewise
$sum_(i=0)^n i$          // summation with limits
$binom(n, k)$            // binomial coefficient

$(x + 1)/x$              // auto-scaling delimiters
```

**Multi-letter variables need quotes:**
```typst
$ Q = "time offset" $
```

---

## Part 2: Styling and Layout

### 2.1 Set Rules (Declarative Styling)

Set rules apply default parameters to all subsequent instances:

```typst
#set text(font: "New Computer Modern", size: 11pt)
#set page(paper: "us-letter", margin: (x: 1.8cm, y: 1.5cm))
#set par(justify: true, leading: 0.52em)
#set heading(numbering: "1.")
#set document(title: [My Paper])
```

**Common set-rule functions:**

| Function | Configures |
|---|---|
| `text` | Font, size, color, weight, style, lang |
| `page` | Paper, margins, header, footer, columns, numbering |
| `par` | Justification, leading, first-line indent |
| `heading` | Numbering, spacing |
| `list` / `enum` | Marker style, spacing |
| `document` | Metadata (title, authors, etc.) |

**Scoped set rules:**
```typst
#[
  #set list(marker: [--])
  - Only this list gets dash markers
]
- This list uses default bullets
```

**Conditional set rules:**
```typst
#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}
```

### 2.2 Show Rules (Transformational Styling)

**Show-set rule** — apply set rule to matched elements:
```typst
#show heading: set text(navy)
```

**Transformational show rule** — redefine rendering:
```typst
#show heading: it => block[
  \~ #emph(it.body) \~
]
```

**Show rule with `where` selector:**
```typst
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 13pt)
#show heading.where(level: 1): smallcaps
```

**Text replacement:**
```typst
#show "Project": smallcaps
#show "badly": "great"
```

**Show-everything (templates):**
```typst
#show: rest => {
  set text(font: "Inria Serif")
  rest
}
```

**Show on labels:**
```typst
#show <intro>: set align(center)
```

**Show on table cells:**
```typst
#show table.cell.where(x: 1): set text(weight: "bold")
#show table.cell.where(y: 0): set text(weight: "bold", style: "italic")
```

### 2.3 Templates and Functions

**Simple function:**
```typst
#let amazed(term) = box[✨ #term ✨]
You are #amazed[beautiful]!
```

**Named parameters:**
```typst
#let amazed(term, color: blue) = {
  text(color, box[✨ #term ✨])
}
```

**Template pattern:**
```typst
#let conf(title, doc) = {
  set page(paper: "us-letter", columns: 2)
  set par(justify: true)
  set text(font: "Libertinus Serif", size: 11pt)
  doc
}

#show: doc => conf([My Paper], doc)
```

**Template with `.with()`:**
```typst
#import "conf.typ": conf

#show: conf.with(
  title: [A Fluid Dynamic Model],
  authors: (
    (name: "Alice", affiliation: "MIT"),
    (name: "Bob", affiliation: "Stanford"),
  ),
  abstract: lorem(80),
)
```

**Anonymous functions:**
```typst
#show: doc => conf([Title], doc)
#(1, 2, 3).map(x => x * 2)
```

### 2.4 Imports and Modules

```typst
#import "conf.typ": conf       // specific items
#import "conf.typ": *          // everything
#import "conf.typ"             // whole module
#import "conf.typ" as paper    // rename module
#import "conf.typ": conf as paper_style  // rename item

#include "chapter1.typ"        // include (evaluates and returns content)

// Package imports
#import "@preview/cetz:0.4.1"
#import "@preview/example:0.1.0": add

// Built-in modules
#import emoji: face
#face.grin
#calc.max(3, 2 * 4)
#sym.pi
```

---

## Part 3: Common Patterns and Idioms

### 3.1 Page Setup

```typst
#set page(
  paper: "us-letter",
  header: align(right)[My Paper Title],
  numbering: "1",
  margin: (x: 1.8cm, y: 1.5cm),
)
```

**Context-dependent headers:**
```typst
#set page(header: context {
  if counter(page).get().first() > 1 [
    My Paper Title
    #h(1fr)
    Author Name
  ]
})
```

**Accessing document title:**
```typst
#set document(title: [My Paper Title])
#set page(header: context align(right, document.title))
#title()   // prints the title
```

### 3.2 Tables

**Basic table:**
```typst
#table(
  columns: 2,
  [Name], [Description],
  [Foo], [$ a^2 + b^2 $],
)
```

**Table with alignment:**
```typst
#table(
  columns: (1fr, 2fr),
  align: (left, center),
  [Name], [Value],
  [Foo], [42],
)
```

**Per-cell alignment:**
```typst
#table(
  columns: 2,
  [Left],
  table.cell(align: center + horizon)[$ x^2 $],
)
```

**Zebra stripes:**
```typst
#set table(
  fill: (rgb("EAF2F5"), none),
  stroke: 0.5pt + gray,
)
```

**Cell merging:**
```typst
#table.cell(colspan: 2)[Spans two columns]
#table.cell(rowspan: 2)[Spans two rows]
```

**Table from CSV:**
```typst
#let data = csv("data.csv")
#table(
  columns: 2,
  ..data.map(row => row.slice(2, 4)).flatten(),
)
```

### 3.3 Figures

```typst
#figure(
  image("glacier.jpg", width: 70%),
  caption: [A glacier in the alps.],
) <glacier>

As shown in @glacier, ...
```

### 3.4 Content Blocks vs Strings

```typst
// Content — can contain markup
#let name = [*bold name*]

// String — plain text only
#let path = "images/logo.png"
```

### 3.5 Argument Spreading

```typst
#let cells = (1, 2, 3, 4)
#table(columns: 2, ..cells)
```

### 3.6 Destructuring

```typst
#let (a, .., b) = (1, 2, 3, 4)
The first is #a, the last is #b.

#let (name, affiliation) = author_data
```

### 3.7 Trailing Content Blocks

```typst
#underline([text])            // normal call
#underline[text]              // trailing content block
#rect(width: 2cm)[content]    // named args then content
```

---

## Part 4: Display vs Inline Math (Critical)

### 4.1 The Space Rule

| Syntax | Mode | Behavior |
|---|---|---|
| `$x^2$` | **Inline** | In text flow, inline sizing |
| `$ x^2 $` | **Display** | Centered block, display sizing |
| `$ x^2$` or `$x^2 $` | **Undefined** | Avoid inconsistent spacing |

### 4.2 Math Sizing Functions

```typst
$ display(sum_i x_i) $     // Force display size
$ inline(sum_i x_i) $      // Force inline size
$ script(x) $              // Script size
$ sscript(x) $             // Second script size
```

### 4.3 The `cases()` Problem in Inline Math

```typst
// Small brace — inline mode
$ cases(1 "if" x > 0, -1 "if" x < 0) $

// Properly sized — display mode
$ cases(1 "if" x > 0, -1 "if" x < 0) $

// Or force display sizing inline:
$ display(cases(1 "if" x > 0, -1 "if" x < 0)) $
```

---

## Part 5: Containers and Alignment

### 5.1 `block` vs `box`

| Feature | `box` | `block` |
|---|---|---|
| Level | **Inline** | **Block** |
| Width | Can use `1fr` | `auto` / fixed |
| Page breaking | N/A | Breakable/unbreakable |
| Use case | Inline padding, fractional widths | Centering, backgrounds, breaks |

### 5.2 Alignment with `block`

`block` has no direct alignment parameter. Options:

**Option A:** `align()` inside:
```typst
#block(width: 100%)[
  #align(center)[
    $ a^2 + b^2 = c^2 $
  ]
]
```

**Option B:** `set align()` before:
```typst
#set align(center)
#block(width: 60%, fill: silver)[
  $ a^2 + b^2 = c^2 $
]
```

### 5.3 Display Math in Tables

```typst
#table(
  columns: 2,
  [Label],
  table.cell(
    align: center + horizon,
    block(width: 100%)[
      $ cases(1 "if" x > 0, -1 "if" x < 0) $
    ],
  ),
)
```

---

## Part 6: Gotchas and Non-Obvious Behaviors

### 6.1 `#` Usage

**`#` is only needed in markup mode**, not inside function args or code blocks:

```typst
#figure(
  image("glacier.jpg"),   // No # — already in code mode
  caption: [A glacier],   // Content block
)
```

### 6.2 Empty `()` vs `[]`

```typst
#title()      // No arguments — uses default
#title[]      // One argument: empty content — prints nothing!
```

### 6.3 Context Keyword

Required for dynamic values (headers, counters):

```typst
#set page(header: context {
  counter(page).get()
})
```

### 6.4 Set Rule Scope

```typst
#[
  #set par(justify: false)    // Only scoped here
  This is not justified.
]
This IS justified.
```

### 6.5 Math Function Calls

```typst
$ sum^10_(i=1) i $            // No # needed for math functions
$ #rect(width: 4mm) / 2 $     // # needed for non-math functions
```

### 6.6 Semicolons in Math 2D Args

```typst
$ mat(1, 2; 3, 4) $          // 2×2 matrix (; separates rows)
```

### 6.7 Page Margin Dictionary

```typst
#set page(margin: (
  top: 3cm,
  bottom: 2cm,
  x: 1.5cm,        // left and right
  inside: 2.5cm,   // toward spine
  outside: 2cm,    // away from spine
  rest: 1in,       // catch-all
))
```

### 6.8 Floats in Multi-Column

```typst
#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 2em,
)[
  #title()
  *Abstract* \ #lorem(80)
]
```

### 6.9 Loop Results Join

```typst
#for c in "ABC" [ #c is a letter. ]
// Produces: "A is a letter.B is a letter.C is a letter."
```

---

## Part 7: Project-Specific Knowledge

> **Also read these files for project-specific rules:**
> - `.opencode/knowledge/typst-writing-rules.md` — 15 rules from Chapter 4 debugging
> - `.opencode/knowledge/typst-styling-knowledge.md` — Math/block/table styling deep-dive

### 7.1 Key Project Rules (Summary)

1. **Code mode vs math mode in macro args**: Never pass `'`, `^`, or nested `#` to macros inside `$...$`
2. **Content macros in math mode**: Omit `#`, use `$ rRhoC(x, m) $` not `$ #rRhoC(x, m) $`
3. **Space before `_`**: `#genvalseqblub _(i=l)` not `#genvalseqblub_(i=l)`
4. **Math identifiers in macro args**: Wrap in `$...$`: `#rvec($x_1$, $dots$, $x_n$)`
5. **No `lfloor`/`rfloor`**: Use Unicode `⌊`/`⌋`
6. **No `superset.eq`**: Use `⊇`
7. **`TRUE`/`FALSE`**: Use `#synTrue`/`#synFalse` or `sans("TRUE")`
8. **Grammar code**: Use `#code(...)` not `#raw(...)`
9. **No double monospacing**: `kw[X]` not `kw[#code[X]]`
10. **BNF short categories**: Inline with `bar.v`, not separate `Or(...)` per symbol

### 7.2 Macro System

- **Syntactic categories**: `synX` / `elemX` naming (set name / generic element)
- **Abstract domain names**: Always use dedicated macros (`genvecdom`, `itvdom`, etc.)
- **Semantic brackets**: `sembrack(x)` / `sembrackSharp(x)`
- **Lattice operators**: Domain-specific with `attach()` for subscripts

### 7.3 Theorem Environments

```typst
#import "@local/unipr-thesis:0.1.0": *

#theorem(title: [...])[...] <label>
#lemma(...)[...] <label>
#proof(...)[...] <label>
```

Available: `theorem`, `lemma`, `corollary`, `proposition`, `definition`, `proof`, `example`, `remark`, `conjecture`, `axiom`, `postulate`.

### 7.4 Chapter Import Pattern

```typst
#import "../macros.typ": *
#import "@local/unipr-thesis:0.1.0": *  // if using theorems
```

---

## Part 8: Quick Reference Cheat Sheet

### Math Mode
```typst
$inline$              // inline math
$ display $           // display math
$sum_(i=0)^n i$       // summation
$mat(1, 2; 3, 4)$     // matrix
$cases(1 "if" x>0)$   // cases
$vec(x_1, x_2)$       // vector
$frac(a, b)$          // fraction
$floor(x)$            // math function
$#rect(width: 1cm)$   // non-math function in math
```

### Styling
```typst
#set text(font: "...", size: 11pt)
#set page(margin: 2cm)
#set par(justify: true)
#show heading: set text(navy)
#show: rest => { set text(font: "..."); rest }
```

### Layout
```typst
#block(width: 100%)[content]
#box($inline math$, inset: 0.2em)
#align(center)[content]
#grid(columns: 2, [a], [b])
#table(columns: 2, [a], [b])
```

### Functions
```typst
#let f(x) = x * 2
#let f(x, y: 1) = x + y
#let f(x) = {
  let y = x * 2
  y + 1
}
```

### Control Flow
```typst
#if x == 1 { .. } else { .. }
#for val in (1,2,3) { .. }
#while x < 10 { .. }
```
