# Notes on The Little Schemer
This document summarizes my notes and findings from reading [The Little Schemer](https://mitpress.mit.edu/books/little-schemer-fourth-edition) by Daniel P. Friedman and Matthias Felleisen.

## The Five Laws
1. The primitive *car* is defined only for non-empty lists.
2. The primitive *cdr* is defined only for non-empty lists. The cdr of any
   non-empty list is always another list.
3. The primitive *cons* takes two arguments. The second argument to cons must
   be a list. The result is a list.
4. The primitive *null?* is defined only for lists.
5. The primitive *eq?* takes two arguments. Each must be a non-numeric atom.

## The Ten Commandments
1. When recurring on a list of atoms, *lat*, ask two questions about it:
    * (*null?  lat*) and
    * **else**.
   When recurring on a number, *n*, ask two questions about it:
    * (*zero? n*) and
    * **else**.
   When recurring on a list of S-expressions, *l*, ask three
   questions about it:
    * (*null? l*),
    * (*atom?* (*car l*)),
    * and **else**.
2. Use *cons* to build lists.
3. When building a list, describe the first typical element, and then *cons* it
   onto the natural recursion.
4. Always change at least one argument while recurring. When recurring on a
   list of atoms, *lat*, use (*cdr lat*). When recurring on a number, *n*, use
   (*sub1 n*). When recurring on a list of S-expressions, *l,* use (*car l*)
   and (*cdr l*) if neither (*null? l*) nor (*atom?* (*car l*)) are true.

   It must be changed to be closer to termination. The changing argument must
   be tested in the termination condition:
    * when using *cdr*, test termination with *null?* and
    * when using *sub1*, test termination with *zero?*.
5. When building a value with +, always use 0 for the value of the termination
   line, for adding 0 does not change the value of an addition.

   When building a value with *, always use 1 for the value of the termination
   line, for multiplying 1 does not change the value of an multiplication.

   When building a value with cons, always consider () for the value of the
   terminating line.
6. Simplify only after the function is correct.
7. Recur on the *subparts* that are of the same nature:
    * on the sublist of a list, and
    * on the subexpressions of an arithmetic expression.
8. Use help functions to abstract from representations.
9. Abstract common patterns with a new function.
10. Build functions to collect more than one value at a time.

## TODO
* [x] Read Chapter 1: Toys
* [ ] Read Chapter 2: Do It, Do It Again, and Again, and Again...
* [ ] Read Chapter 3: Cons the Magnificent
* [ ] Read Chapter 4: Numbers Games
* [ ] Read Chapter 5: \*Oh My Gawd\*: It's Full of Stars
* [ ] Read Chapter 6: Shadows
* [ ] Read Chapter 7: Friends and Relations
* [ ] Read Chapter 8: Lambda the Ultimate
* [ ] Read Chapter 9: ...and Again, and Again, and Again, ...
* [ ] Read Chapter 10: What is the Value of All of This?
