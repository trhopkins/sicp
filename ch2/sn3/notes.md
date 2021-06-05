# Chapter 2, Section 3: Symbolic Data

* **Symbolic data:** arbitrary, named 'variables' which are first-class
  citizens of our language. Typically indivisible, not required to correspond
  to a value in memory when manipulated as data.
* **Atom:** indivisible data element, like a number of symbol.
* **Symbolic expression:** pair, list, or atom that can be manipulated as data
  (everything, basically).
* **Quotation:** differentiating between syntactic and semantic entities. A
  quoted symbol refers to that symbol, not its value or contents.
* **Quote:** treat the following data element as data rather than something to
  evaluate. Single-quote acts as shorthand for clarity.
* **Call-by-reference:** refer to the symbol (representation) rather than its
  data. Comparisons with eq? on symbols is a good example. Can also refer to an
  object's location in memory. AKA CBR.
* **Call-by-value:** refer to the data a symbol refers to. AKA CBV.
* **Quasiquotation:** quote an entire list of items, but eval any items with an
  unquote (comma). Useful for writing macros, pattern matchers, interpreters,
  DSLs, and syntax-parsers. AKA backquote or backtick.

The following data types are not symbols:
* Numbers.
* Strings.
* Characters.
* Vectors (not defined in Scheme).
* Lists.
* Pairs.

Symbols are kind of like zero-ary (no argument) functions which return their
top-level value according to their environment. This idea is useful when
dealing with Church Numerals and that sort of thing.

* **Eqv?:** check if two symbols are the same, or if two objects have the same
  location in memory.
* **= (numeric equality):** check if two numbers are the same. Works between
  integers, rationals, complexes, etc. CBR.
* **Eqv?:** check if two primitive values are the same. Like an expanded "="
  for strings, numbers, symbols, etc. CBV.
* **Equal?:** check if two symbolic expressions are the same. Works with lists.
  CBV.

