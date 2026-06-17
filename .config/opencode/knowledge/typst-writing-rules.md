# Typst Writing Rules — Lessons from Chapter 4

These rules were discovered while debugging compilation of `chapters/04-operators.typ`. Follow them to avoid the same errors in future chapters (5-8) and appendices.

---

## 1. Code Mode vs Math Mode in Macro Arguments

**Inside `$...$` math blocks, `#macro(args)` evaluates arguments in CODE mode.** Code mode has restricted syntax:

| Character | Code mode | Math mode |
|-----------|-----------|-----------|
| `'` (prime) | Starts a string literal — **INVALID** | Valid (produces prime) |
| `^` (hat) | **INVALID** | Valid (superscript) |
| `#` (hash) | **INVALID** (nested macro call) | Triggers code mode |
| `_` (underscore) | Valid in identifiers only | Valid (subscript) |

**Rule**: Never pass arguments containing `'`, `^`, or nested `#` to a macro inside `$...$`.

**Bad**:
```typ
$ #rvec(x'_1, dots, x'_m)_(A'_1) $     // ' in code mode → error
$ #rRhoC(#rvec(1, 2), 3) $             // nested # in code mode → error
$ #rhoCSharp(known^i, i, n) $           // ^ in code mode → error
```

**Good alternatives**:
```typ
// Use raw math brackets instead of #rvec for primed args
$ [x'_1, dots, x'_m]_(A'_1) $

// Move macro call outside $...$, add space before paren
#rRhoC (#rvec(1, 2), 3)

// Use $...$ wrapping inside macro arg
#rhoCSharp ($known^i$, i, n)
```

**Exception**: Simple args (bare numbers, simple keywords like `1`, `2`, `genvalbot`, `attrEmpty`) work fine in code mode. The problem only arises with math notation like primes, hats, and nested macros.

---

## 2. Content Macros in Math Mode: Omit `#`

For `let` bindings that hold **content** (not functions), Typst's math mode resolves names **without `#`** via the `MathCall` mechanism. This is cleaner, avoids spacing issues with parentheses, and works natively.

**Bad** — using `#` with content macros inside `$...$`:
```typ
$ #rRhoC(x, m) $          // # triggers code mode → error: "expected function, found content"
$ #rRhoC (x, m) $         // space works but is a workaround for the wrong approach
$ #rCast(x, t) $
```

**Good** — omit `#`, let math mode resolve the name:
```typ
$ rRhoC(x, m) $           // content "ρ_c" followed by literal math (x, m) ✓
$ rCast(x, t) $           // content "Cast" followed by literal math (x, t) ✓
$ rTau(x) union.sq rTau(y) $
$ rRecycle(x, y) $
```

**What happens internally**: Typst parses `rCast(x, t)` as a `MathCall` AST node. It looks up `rCast` via `get_in_math()` (which searches local scopes, then the built-in math module). Since `rCast` holds content (not a function), Typst **unparses** the arguments: it renders the content "Cast" followed by literal `(x, t)` in math mode. Named arguments and spread syntax error here — they only work with actual functions.

**When to add a space before `(`** (fallback):
If for some reason you must use `#rRhoC` inside `$...$`, a space before `(` terminates the code expression so `(...)` is parsed as regular math:
```typ
$ #rRhoC (x, m) $
```
But prefer the `#`-less form above.

Macros that benefit from the `#`-less style: `rRhoC`, `rTau`, `rCast`, `rRecycle`, `rRecycleSharp`, `rhoCSharp`, `rhoFSharp`, `squash`, `squashExcept`, `genvallub`, `genvalblub`, `genvalglb`, `defEq`, `rSelectSharp`, `rUpdateSharp`, `vecConcatSharp`, and any other `#let name = { ... }` producing content.

**⚠️ When a content macro must be immediately followed by a function call** (e.g., `squash#lrpar(...)`), use the **hybrid pattern** described in Rule #11: keep the `$...$` wrapper, use MathCall for content, `#` only for actual functions, and no space between them.

---

## 3. Macro Name + `_` Needs Space

Typst parses `#macroname_` as an identifier with a trailing underscore, not as attachment.

**Bad**:
```typ
#genvalseqblub_(i=l)^(max)     // parsed as "genvalseqblub_" → unknown variable
#genvalblub_(k=1)^(m)          // same issue
```

**Good** — space before `_`:
```typ
#genvalseqblub _(i=l)^(max)
#genvalblub _(k=1)^(m)
```

---

## 4. `()` After Content Macros — Use `#`-Less Form

The `()` after a `#`-prefixed content macro triggers a function call error (content is not callable). Solved by omitting `#` inside math mode (Rule #2) or adding a space.

**Bad**:
```typ
#genvallub()_(i=1)^(n) p_i    // #genvallub() → calls content as function
```

**Good** — omit `#` inside `$...$`:
```typ
$ genvallub ()_(i=1)^(n) p_i $
```
Or add space before `()` in code mode:
```typ
#genvallub () _(i=1)^(n) p_i
```

---

## 5. Math Identifiers as Macro Args → Wrap in `$...$`

Inside `$...$`, macro arguments like `c_1`, `x_n`, `p_i` are parsed as code variables. If they're not defined Typst variables, they error.

**Bad**:
```typ
$ #rvec(c_1, dots, c_n)_A $       // c_1 unknown variable
$ #rvec(x_1, dots, x_n) $          // x_1 unknown variable
```

**Good** — wrap each identifier in `$...$`:
```typ
$ #rvec($c_1$, $dots$, $c_n$)_A $
$ #rvec($x_1$, $dots$, $x_n$) $
```

Or better yet, use raw math brackets (avoid the macro entirely inside `$...$`):
```typ
$ [c_1, dots, c_n]_A $
```

---

## 6. `dots` vs `$dots$` in Macro Args

`dots` is a Typst built-in but may not resolve in all macro-argument contexts. Inside `$...$` macro args, use `$dots$` to produce `...` via math mode.

**Safe pattern**:
```typ
#rvec($x_1$, $dots$, $x_n$)     // each arg is a $...$ code expression
```

---

## 7. No `lfloor`/`rfloor` — Use Unicode `⌊` `⌋`

Typst math does not have `lfloor`/`rfloor` as named functions. Use the Unicode characters directly:

**Bad**:
```typ
$ lfloor l/n rfloor $
```

**Good**:
```typ
$ ⌊l/n⌋ $
```

(These are U+230A LEFT FLOOR and U+230B RIGHT FLOOR.)

---

## 8. No `superset.eq` — Use `⊇` or `supset.eq`

In Typst math, `superset` is not a recognized symbol. The superset-or-equal relation is:

```typ
$ A ⊇ B $          // Unicode U+2287
// or
$ A supset.eq B $  // may work depending on Typst version
```

Prefer the Unicode character `⊇` for reliability.

---

## 9. `True`/`False`: Syntax vs Semantic Distinction (Critical)

R's logical constants appear in two distinct roles:

1. **Syntax-level** (R keywords `TRUE`, `FALSE`) → use `synTrue` / `synFalse`
2. **Semantic-level** (mathematical values `True`, `False` → paper uses `\textsf{True}`) → use `semTrue` / `semFalse`

**Bad** (bare identifiers):
```typ
$ #rvec(TRUE, rNA) $
$ c'(i) = TRUE $
```

**Good**:
```typ
// Syntax context (grammar productions, keyword references):
Or($synTrue$)
Or($synFalse$)

// Semantic context (formulas, definitions):
$ c'(i) = #semTrue $
$ #rvec(sans[True], rNA) $     // sans[..] when nested inside #rvec(...) args
$ #sans[True] $                 // sans[..] with # prefix inside $...$
```

**Available macros in `macros.typ`:**
- `synTrue` / `synFalse` — keyword-styled (monospace blue) R keywords `TRUE`/`FALSE`
- `semTrue` / `semFalse` — sans-serif semantic values `True`/`False`

**Nested context caveat:** Inside `#macro(...)` arguments in `$...$`, use `sans[True]` instead of `#semTrue` to avoid nested-`#` parsing issues.

---

## 10. `rdom` Macro Was Broken

Original:
```typ
#let rdom(body) = "dom"(body)    // "dom" is a string, can't be called
```

Fixed:
```typ
#let rdom(body) = $"dom"(#body)$  // math: "dom" with body as argument
```

---

## 11. Hybrid Pattern: MathCall Content + `#` Functions Inside `$...$`

When a content macro (e.g., `squash`) must be followed by a **function** macro (e.g., `lrpar`) inside `$...$`, keep the `$...$` wrapper and use the hybrid pattern: MathCall (no `#`) for content macros, `#` only for actual functions, with no space between them.

**Bad** — removing `$...$` wrapper and converting everything to content mode:
```typ
// Wrong: loses math context, forces $...$ wrapping of pure-math parts
#squash #lrpar($[l, u]$, $known$, $s$, $a$) #defEq #genvallub $()_(i=1)^(abs(known)) p_i$ #genvallub $s$
```

**Good** — keep `$...$`, use MathCall for content, `#` only for functions:
```typ
$
  squash#lrpar($[l, u]$, $known$, $s$, $a$) defEq genvalblub_(i=1)^(abs(known)) p_i genvallub s
$
```

Key points:
- `squash` (content) → MathCall, no `#`
- `#lrpar(...)` (function) → needs `#` to be called
- `defEq`, `genvalblub`, `genvallub` (all content) → MathCall, no `#`
- No space between `squash` and `#lrpar` → no visible space in output
- Math-only variables (`p_i`, `s`) are already in math mode, no wrapping needed
- Macro arguments to functions need `$...$` wrapping: `$[l, u]$`, `$known$`, `$s$`, `$a$`

This hybrid pattern avoids the nested-code-mode issues while keeping the clean math-mode context.

**⚠️ Do NOT convert to pure content mode** (removing `$...$` wrapper entirely). That approach forces you to wrap every math variable in `$...$` and is more error-prone.

---

## 12. `#code` Not `#raw` for Grammar Code Pieces

---

## 12. `#code` Not `#raw` for Grammar Code Pieces

In grammar/BNF contexts, use the dedicated macro `#code("...")` for code literals (operators, symbols, language tokens), not `#raw("...")`. `#raw` is for verbatim text display; `#code` applies monospaced styling consistent with the thesis style.

**Bad**:
```typ
Or($elemV #raw("<-") #elemE$)
```

**Good**:
```typ
Or($elemV #code("<-") elemE$)
```

---

## 13. `kw` + `#code` is Redundant (No Double Monospacing)

The `kw(body)` macro already applies `mono(text(fill: kwCol)[body])`. Wrapping it with `#code` inside is redundant — both apply monospacing. Use `kw[X]` directly, not `kw[#code[X]]`.

**Bad**:
```typ
#let synTrue = kw[#code[TRUE]]
#let synNA = kw[#code[NA]]
```

**Good**:
```typ
#let synTrue = kw[TRUE]
#let synNA = kw[NA]
```

---

## 14. BNF: Inline `bar.v` for Short Single-Symbol Categories

For syntactic categories that consist of a few single-symbol alternatives (operators like `+`, `-`, `*`, `/`), compress them into one `Or(...)` with inline `bar.v` separators inside `$...$` rather than separate `Or(...)` calls per symbol.

**Instead of**:
```typ
Prod($#synArithOp$, {
  Or($#code("+")$)
  Or($#code("-")$)
  Or($#code("*")$)
  Or($#code("/")$)
})
```

**Write**:
```typ
Prod($#synArithOp$, {
  Or($#code("+") bar.v #code("-") bar.v #code("*") bar.v #code("/")$)
})
```

Note: `bar.v` is a Typst math-mode built-in symbol (vertical bar `|`), so it takes **no `#` prefix** inside `$...$`. `#code(...)` keeps `#` because `code` is a function, not a content macro.

---

## 15. Summary Checklist for New Chapters

Before compiling a new chapter, verify:

- [ ] No `'` (prime) inside `#macro(args)` when inside `$...$`
- [ ] No `^` (hat/superscript) inside `#macro(args)` inside `$...$`
- [ ] No nested `#macro(#macro2(...))` inside `$...$`
- [ ] Content macros in math mode: omit `#`, use `$ rRhoC(x, m) $` not `$ #rRhoC(x, m) $`
- [ ] Content macro + function call: hybrid pattern `$ squash#lrpar(...) $` (no space, keep `$...$`, `#` only on functions)
- [ ] Space before `_` attachment: `#genvalseqblub _(i=l)` not `#genvalseqblub_(i=l)`
- [ ] Math identifiers in macro args wrapped in `$...$`: `#rvec($x_1$, $dots$, $x_n$)`
- [ ] `dots` in macro args is `$dots$`
- [ ] No `lfloor`/`rfloor` — use `⌊`/`⌋`
- [ ] No `superset.eq` — use `⊇`
- [ ] `TRUE`/`FALSE` → `sans("TRUE")` or `#synTrue`/`#synFalse`
- [ ] `rdom` is fixed in macros.typ
- [ ] For vectors with primed variables: use raw `$[x'_1, dots, x'_n]_(A')$` instead of `#rvec`
- [ ] Grammar code pieces: use `#code(...)` not `#raw(...)`
- [ ] `kw[X]` not `kw[#code[X]]` — no double monospacing
- [ ] Short single-symbol BNF categories: inline with `bar.v`, not separate `Or(...)` per symbol
