# Chapter 2: Do it, Do it Again, and Again, and Again... (p. 14)

Are you rested?

* A *lat* is a list of atoms.
* When evaluating a function, answer every question in order.
* **define** names things.
* **lambda** defines a function.
* **cond** asks a question.
* **else** is a question which is always true.
* **or** evaluates two questions, one at a time. If either is #t, it returns #t.

*lat?* looks at each S-expression in a list, in turn, and asks if each S-expression is an atom, until it runs out of S-expressions. If it runs out without encountering a list, the value is #t. If it finds a list, the value is #f--false.
```Scheme
(define lat? ; see page 16
  (lambda (l)
    (cond
      ((null? l)
        #t)
      ((atom? (car l))
        (lat? (cdr l)))
      (else
        #f))))
```

*member?* looks at each atom in a list of atoms and returns true if it finds an atom matching your search. If it runs out without encountering your search term, it returns #f.
```Scheme
(define member? ; see page 22
  (lambda (a lat)
    (cond
      ((null? lat)
        #f)
      (else
        (or (eq? a (car lat))
            (member? a (cdr lat)))))))
```
The First Commandment: (preliminary) always ask *null?* as the first question in expressing any function.

Do you believe all this? Then you may rest!
