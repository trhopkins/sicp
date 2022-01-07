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

(define (sum term a next b) ; higher-order function
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b)))) ; recursive, try iterative?

(define (identity n)
  n)

(define (inc n)
  (+ n 1))

(define (sum-integers a b)
  (sum identity a inc b))

(define (square n)
  (* n n))

(define (sum-squares a b)
  (sum square a inc b))
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

Note: some implementations of Scheme actually use let as their most basic,
primitive function application and variable assignment operator. Since the
special forms are interchangeable beyond an aesthetic level, either one is
perfectly valid. You can test this with the **expand** operator. Chez Scheme
actually uses let over lambda as a special form.

In general, lambda expressions are written as follows:
`(lambda (<parameters>) <body>)`.
They come from *the lambda calculus,* a mathematical formalism for describing
functional procedures discovered/invented by Alonzo Church in 1932. The lambda
calculus is entirely functional, and only features three operators: lambda,
symbols, and function applications. in BNF, the language can be described as
the following:

> e ::= x | lambda x . e | e_0 e_1.

While you might be drawn to the idea of writing a Scheme program entirely in
lambdas, and that is very possible (see The Lambda Papers by Guy Steele and
Gerry Sussman), it is not practical because it does not translate to pragmatic,
readable code. Learn to use idioms and common design patterns with the built-in
primitive special forms like let, lambda, define, cond, etc. and you will write
more beautiful, more reusable code.

* **Fixed point:** a value for which a function returns that same value.
* **Average damping:** using the average of a function's input and output as the
new input until it reaches a fixed point.

```Scheme
;; sample fixed point code based on a higher-order function
(define tolerance 0.001) ; can be much smaller for more precision
(define (fixed-point f initial-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try initial-guess))

(define (average-damp f x)
  (lambda (x) (average x (f x))))

;; reformulating square root function
(define (sqrt n)
  (fixed-point (average-damp (lambda (y) (/ x y))
                             1.0)))
```

The code snippets above achieve their power by *returning functions as values,*
further demonstrating the usefulness of first-class functions. This is useful
when dealing with transformations of functions, like when deriving values in
calculus, or when immediately applying these transformations to inputs like in
the case given above.

**Newton's method:** if x -> g(x) is differentiable, then a solution of g(x) =
0 is a fixed point of the function x -> f(x), where f(x) = x - (g(x)/g'(x)),
where g'(x) is the derivative of g evaluated at x. This method converges very rapidly towards a correct answer for some cases, like the deriv case given below.

```Scheme
;; derivative calculation in Scheme
;; f'(x) = (f(x + dx) - f(x)) / dx
(define dx 0.000001) ; dx approaches 0

(define (deriv f)
  (lambda (x)
    (/ (- (f (+ x dx)) (f x))
       dx)))

;; example use of deriv. Try on your calculator!
;((deriv (lambda (x) (* x x x))) 5) ; approximately 75

;; page 74-75
(define (newton-transform f)
  (lambda (x)
    (- x (/ (f x) ((deriv f) x)))))

(define (newtons-method f x)
  (fixed-point (newton-transform f) x))

(define (sqrt x) ; putting Newton's method to use
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))
```

So far we have seen two ways of computing square root: one using a fixed-point
transformation, and one using Newton's method, which also uses fixed-point
transformations. This can be generalized even further as a function that inputs
a function and returns a fixed point transformation of that function:

```Scheme
(define (fixed-point-of-transform f transform x)
  (fixed-point (transform f) x))

(define (sqrt x)
  (fixed-point-of-transform (lambda (y) (/ x y))
                            average-damp
                            1.0))

(define (sqrt x) ; last time I swear
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))
```

As programmers, it is our job to identify the underlying abstractions in our
programs and to build upon them and generalize them to create even more
powerful abstractions.

The rights and privileges of first class citizens:
* They may be named as variables
* They may be passed as arguments to procedures
* They may be returned as the results of procedures
* They may be included in data structures
