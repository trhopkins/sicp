# Chapter 1, Section 2: Procedures and the Processes they Generate (p. 31)

A procedure is a **local evolution** of a computer process. It defines its own
environment and behavior, which is really just one component of the **global
environment.** This ties into lexical scoping and **namespaces,** or the list
of known variables that a process has access to. Some of these variables are
procedures themselves!

**Recursion** is when a process calls itself during evaluation. There are two
primary kinds of recursion to consider in this section: **linear** and
**iterative** recursive. Linear recursion **defers its operations** until it
reaches its **base case**, requiring additional memory to hold the operations.
An iterative process uses **state variables** to carry its operations with it
until it reaches its **closure statement.** This is also known as an **exit
statement.**

Consider the following two definitions of a factorial calculator:

```Scheme
(define fact ; linear
  (lambda (n)
    (if (= n 1)
        1
        (* n (fact (- n 1))))))
```

This function is pretty simple. Its iterative counterpart is a bit more complex:

```Scheme
(define fact ; iterative
  (lambda (n)
    (define iter
      (lambda (p c) ; product, counter
        (if (> c n)
            p
            (iter (* p c)
                  (+ c 1)))))
    (iter 1 1)))
```

Now let's look at the expansion of each function evaluation for `(fact 5)`.

```Scheme
(fact 5)
(* 5 (fact 4))
(* 5 (* 4 (fact 3)))
(* 5 (* 4 (* 3 (fact 2))))
(* 5 (* 4 (* 3 (* 2 (fact 1)))))
(* 5 (* 4 (* 3 (* 2 1))))
(* 5 (* 4 (* 3 2)))
(* 5 (* 4 6))
(* 5 24)
120
```

Notice the expanding and contracting motion above. Once the function reaches
its base case, it starts raveling itself back up. Now look at the iterative
version:

```Scheme
(fact 5)
(iter 1 1)
(iter 1 2)
(iter 2 3)
(iter 6 4)
(iter 24 5)
(iter 120 6)
120
```

The linear recursive function uses O(N) space, while the iterative function
uses O(1) space. **Imperative languages** like C or Pascal use **looping
constructs** to define iterative processes, and use a **stack** data structure
to store information about recursive processes. In later chapters we will learn
about how **tail recursion** eliminates the need for excessive memory
consumption during iterative processes.

* **Syntactic sugar:** a linguistic abstraction that simplifies programmatic
  expression.
* **Tree recursion:** a function recursively calling itself several times.
* **Tabulation:** storing computed values to be recalled if a function is
  called several times with the same inputs. AKA **memoization.**
* **Order of growth:** the time and space complexity used by a process.
  Described with **"Big-O notation,** it includes O(1), O(N), O(N^2), etc.
* **Logarithmic growth:** a problem with O(log(N)) complexity. Multiplying the
  input (usually doubling) increases the number of operations by a constant
  factor.

When describing the resources a procedure takes, we measure **time
complexity,** or how many operations are performed, and **space complexity,**
or how much memory is consumed. We can describe it with different kinds of
notation:
1. **Big O notation:** a general maximum classification of growth, ignoring
   coefficients and lesser terms, only focusing on the largest terms of the
   complexity expression.
2. **Theta notation:** a bounded range of values of possible complexity,
   between k1 and k2. Often used for space complexity.
3. **Omega-notation:** a general minimum (best-case) scenario for growth. Can
   be very small!
4. **Little o notation:** see CLRS
5. **Little theta notation:** see CLRS

If a shortcut in computation appears, you can add a condition where your
iterative function chooses an alternative path including the shortcut. See the
exponentiation trick on page 45.

