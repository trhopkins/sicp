# The Little Schemer, Chapter 1: Toys
Page 2.

## Remember the five rules!

* An atom is a string of letters, numbers, or characters that do not begin with
  '(' or ')'.
* An S-expression is an atom, a function, or a list.
* A list is a collection of S-expressions bound by parentheses.
* The null list is a list with no items, or ().  A list can contain any number
  of S-expressions, including other lists.
* *car* is a function that takes a non-empty list and returns the first
  S-expression.
* *cdr* is a function that takes a non-empty list and returns a list containing
  all S-expressions minus the first one.
* In other words, everything except for the *car* of that list.
* *cons* is a function that takes an S-expression and a list, and adds the
  S-expression to the front of the list.
* *null?* takes a list and returns #t if that list is empty, and #f otherwise.
* *eq?* takes two non-numeric atoms and returns #t if they are equal, and #f
  otherwise.
