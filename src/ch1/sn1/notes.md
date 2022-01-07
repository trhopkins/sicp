# Chapter 1, Section 1: [The Elements of Programming](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1) (page 4)

> We are about to study a *computational process.* Computational processes are
> abstract beings that inhabit computers. As they evolve, processes manipulate
> other abstract things called *data.* The evolution of a process is directed
> by a pattern of rules called a *program.* People create programs to direct
> processes. In effect, we conjure the spirits of the computer with our spells.

* **programming language:** symbolic expression of a program's structure
  composed of instructions.
* **bug/glitch:** error in programming (syntax, logic, intermittent).
* **debugging:** fixing bugs in a program.

Lisp is a programming language invented by John MacCarthy in 1958. Lisp is
short for **lis**t **p**rocessing. It is called that because Lisp treats code
as atoms and lists, which can be represented as tree structures. It was first
used to describe recursion equations. Nowadays, it is a more general-purpose
language with many dialects in popular use, like Clojure and Common Lisp. The
Lisp dialect used in this book is Scheme, a minimal dialect invented by Guy
Steele Jr. and Gerald Jay Sussman in 1986.

Powerful programming languages express procedures by dealing with complexity
with three primary mechanisms:

1. **Primitive expressions,** which represent the simplest entities the
   language is concerned with,
2. **Means of combination,** by which compound elements are built from simpler
   ones, and
3. **Means of abstraction,** by which compound elements can be named and
   manipulated as units.

Generally, as programmers we deal with two kinds of elements: procedures and
data. Lisp blurs the line between them by treating procedures as first-class
citizens that can be manipulated as data, however.

* **Expression:** primitive term evaluted by an interpreter.
* **Interpreter:** program that reads instructions, evaluates them, and prints
  the results.
* **REPL:** read-eval-print loop. Used by interpreters to handle instructions.
* **Combination:** procedure application expression composed of an operator and
  operands wrapped in parentheses.
* **Operator:** function in a combination that performs a procedure on its
  arguments.
* **Operand:** expression in a combination that is manipulated by an operator.
* **Prefix notation:** placing operators before operands in combination
  expressions.
* **Nesting:** placing a combination or expression within another combination.
* **Variable:** named value in the environment.
* **Environment:** memory allocated to a program containing procedures,
  variables, etc.
* **Pretty-printing:** formatting arguments of a procedure to be vertically
  aligned for ease of nesting and reading.
* **Define:** simplest means of abstraction. Binds names to data or procedures.

To evaluate a combination, do the following (notice the recursion):

1. Evaluate the subexpressions of the combination.
2. Apply the operator to the operands.

To deal with primitive cases, consider that

1. Values of numeral atoms are the numbers they name,
2. The values of built-in operators are the machine instruction sequences that
   carry out the corresponding operations, and
3. The values of other names are the objects associated with those names in the
   environment.

Assigning values to primitives is really just extending the environment of your
program. You can extend it by binding names to primitive values with define, or
by adding new procedures with **lambda,** a special case function that will be
explained later. Actually, some of this information might just be inaccurate,
and will be revised later.

* **Recursive function:** procedure that calls itself as one of its operations.
* **Tree accumulation:** combination values percolating up for evaluation.
* **Special form:** exception to the general evaluation rule. Define, Lambda,
  etc.
* **Substitution model:** replace function definition variables with arguments
  and evaluate, then return the result.
* **Applicative order:** evaluate the arguments, then apply.
* **Normal order:** fully expand, then reduce.
* **Case analysis:** special form of evaluation that evaluates clauses.
* **If:** special form of case analysis with predicate, consequent, and
  alternative in that order, no other expressions.
* **Clause:** conditional statement made of a predicate and consequent.
* **Predicate:** procedure that returns #t if condition is met or #f otherwise.
* **Consequent:** procedure or value to return if predicate is #t.
* **Else:** special form of a predicate which is always #t.
* **And:** logical composition operator that returns #t if all its arguments
  are #t and none are #f.
* **Or:** logical composition operator that returns #t if at least one of of
  its arguments are #t.
* **Not:** logical composition operator that returns #t if its argument is #f,
  and #f if its argument is #t.

To get a square root, simply describing its mathematical definition is not
enough. You must describe the process of getting the result. Describing
properties of something is **declarative knowledge,** while **imperative
knowledge** means describing the methods required to get an answer. Math is
concerned with *"what is"* descriptions, while computer science is concerned
with *"how to"* descriptions. You can define a square root of x as being y
squared, or you can use Newton's method of computing square roots to find the
answer yourself. See page 23.

Defining a process recursively, that is, in terms of itself, may seem
disturbing. Don't worry, with a few statements of inductive logic it all checks
out. Consider decomposing your functions into components with a tree structure,
and treat each component as a unique, atomic piece of its own. Ignoring the
internal structure of a function and only considering the inputs/outputs this
way is called **black box abstraction.** Black box abstraction is one way of
doing **procedural abstraction,** the process of abstracting details away from
the programmer through *wishful thinking.* You can just put the responsibility
of programming a function on some other programmer and assume it acts how you
want, then focus on implementation later.

A function's parameters define those values locally, until they are no longer
needed. They can override a variable's value inside just one function,
extending that function's internal environment, by **binding** the value to the
parameter within the body. In a **lexical scoping** interpreter, a function's
internal environment is extended by its external environment also. If a
variable is not bound to a parameter, it is a **free** variable, pulling from
its global/external environment. Binding a free variable to a parameter is
called **capturing** that variable, within the **scope** of the local
environment. This allows you to avoid conflicting **namespaces** between
different functions. You can even define functions within other functions in a
**block structure.** This is useful when you want to define a context-specific
function that is only useful for one task, like an iterative recursive function
that is only intended for used by one other function.

See [lecture 1A](https://www.youtube.com/watch?v=-J_xL4IGhJA&list=PLE18841CABEA24090)
for a discussion of this section in more detail, as well as a demonstration of
Scheme.
