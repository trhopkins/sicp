# Chapter 1, Section 3: Formulating Abstractions with Higher-Order Procedures (p. 56)

Procedures are simply generalized abstractions of compound operations on inputs
independent of the inputs themselves. They define the methods for finding
outputs, not the outputs themselves. Abstracting away details of computation
allows for clarity, precision, and efficiency. By abstracting away the details
of a procedure by manipulating it as data, we create **higher-order
procedures** that can pass procedures as inputs or outputs. This is because in
Scheme, procedures are **first-class citizens** that have all the rights of any
other data type; they are *indistinguishable from data.*

Higher-order procedures allow you to abstract away general operations like
summing a series of numbers, applying an operation to every item in a list, or
performing an operation until it converges on a certain value. The example
below demonstrates how higher-order procedures can act as **templates** for
slotting in your own operations as necessary.

```Scheme
;; example of passing functions as arguments

(define (sum-integers a b)
  (sum identity a inc b))

(define (sum-squares a b)
  (sum square a inc b))

(define (sum term a next b) ; higher-order function
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (identity n)
  n)

(define (inc n)
  (+ n 1))

(define (square n)
  (* n n))
```

Defining elementary procedures like inc above isn't very pragmatic; sometimes
you don't want to name a single-use function before applying it. the **lambda**
procedure is a special form that allows you to anonymously describe functions.

```Scheme
;; defining a function, with and without lambda

(define (<name> <parameters>) ; syntactical sugar
  (<body>))

(define <name> ; what the interpreter sees
  (lambda (<parameters>)
    (<body>)))

((lambda (n) (+ n 1)) 4) ; 5. This is the same as (inc 4)
```

The special form **let** can be used for binding local variables instead of
define or lambda. Let defines variables with name-expression pairs, followed by
a body where those variables can be called.

```Scheme
;; general form of let

(let ((<var1> <expr1>) ; more sugar
      (<var2> <expr2>) ; expr can be a function also
      ; ...
      (<varn> <exprn>))
     (<body>))

((lambda (<var1> ; what the interpreter sees
          <var2>
          ; ...
          <varn>)
   (<body>)
 <expr1>
 <expr2>
 ; ...
 <exprn>)) ; as it turns out, lambda is super versatile
```

Pragmatic Scheme code tends to use let for simple and define for internal
functions. Use define if the function reads better with the name substituted
rather than a lambda.

The rights and privileges of first class citizens:
* They may be named as variables
* They may be passed as arguments to procedures
* They may be returned as the results of procedures
* They may be included in data structures
