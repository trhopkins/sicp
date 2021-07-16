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

Differentiating an expression is the process of following a simple set of
reduction rules to convert the function f(x) to f'(x), its derivative. The
reduction rules for addition and multiplication work as follows:
* dc/dx = 0
* dx/dx = 1
* d(u+v)/dx = du/dx + dv/dx
* d(uv)/dx = u(dv/dx) + v(du/dx)

The first two rules are base cases, and the latter two rules are typical
elements, which are recursive in nature. A symbolic expression of addition and
multiplication serves as our natural recursion. All this allows us to follow a
divide-and-conquer strategy of decomposing the problem into smaller and smaller
parts until it is fully reduced. I'm going to skip most of the example because
it's not super relevant to the rest of the book aside from its associated
exercises, which are all neat, but not critical to understanding what symbol
manipulation is all about.

Representing sets:
* A set is a collection of distinct objects.
* Make-set = return a new, empty set.
* Empty? = return true of the set contains no objects.
* Element? = check if an object is a member of a set. AKA member?
* Adjoin = add an object into a set and return the new set.
* Union = take two sets and return the objects that appear in either.
* Intersect = take two sets and return the objects that appear in both.

As long as all of these operations on sets behave consistently, we can
represent the sets themselves however we like. Representing them as unordered
lists means each operation has O(N) complexity, and if there are duplicates in
any set, problems occur.

Representing sets as ordered lists (each object can be compared to each other)
means we can cut the average search through a list in half, but the linear
O(N/2) complexity remains.

Representing sets as binary trees allows search and insert operations to be
performed in O(log n) time. This still requires objects to be enumerable and
ordered, however. Ironically, it requires a lot of structure to represent sets,
which do not contain any structure themselves.

