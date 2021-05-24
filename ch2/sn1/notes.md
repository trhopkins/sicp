# Chapter 2, Section 1: Introduction to Data Abstraction (page 83)

* **Data abstraction:** isolating how a compound data object is used from the
  details of its construction.
* **Selector:** procedure that returns a data element from compound data.
* **Constructor:** procedure that glues data elements into compound data.
* **"Concrete" data:** compound data representation separate from its use.
* **Wishful thinking:** write higher-level code first, then write underlying
  representation later.
* **Cons:** construct two elements into a pair, or insert an element onto the
  head of a list.
* **Car:** take the first element of a pair, or the head of a list.
* **Cdr:** take the second element of a pair, or the tail of a list.
* **Abstract Data Type:** specification for a data structure, divorced from its
  implementation. Usually an interface of methods in OOP. AKA ADT.
* **Pair:** compound data structure of two S-expressions glued together.
* **List:** compound data structure of several pairs glued together in
  sequence. AKA Linked List.
* **List-structured data:** data object(s) constructed from pairs.
* **Tree:** hierarchy of nodes, consisting of subtrees, starting at the root,
  then followed by branches, and terminated with leaf-nodes.

```Scheme
;; rational arithmetic operations as Scheme procedures

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* denom x) (denom y)))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (numer x) (denom y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))
```

Here are the underlying representation...

```Scheme
;; basic scheme for rational numbers
(define (make-rat n d) ; constructor
  (cons n d))
(define (numer x) ; selector
  (car x))
(define (denom x) ; selector
  (cdr x))

;; simpler declarations
(define make-rat cons)
(define numer car)
(define denom cdr)
```

* **Abstraction barrier:** barriers isolating different 'levels' of
  representation like a tower. Each level is its own DSL of sorts.
* **Domain-specific language:** Set of definitions/operations that perform one
  task only. AKA DSL.
* **Data:** representation formed with constructors, selectors, and a
  specification for how they relate. The underlying representation is not
  important and may be abstracted away.
* **Abstract model:** procedures plus conditions that construct compound data
  types from primitive ones.
* **Algebraic specification:** regard 'procedures' as abstract algebraic
  systems, whos behavior is defined by axioms ('conditions').
* **Message passing:** represent data as procedures, and pass procedures among
  each other, with arguments as data. Comes from SmallTalk.
* **Object-oriented programming:** representing data as objects, and functions
  as methods. Objects pass messages between each other. In some languages, they
  can modify internal state.
* **Church Numeral:** representation of numbers as procedures, starting with
  zero as identity.

```Scheme
;; procedural data model
(define (cons x y)
  (define (dispatch m)
    (if (= m 0)
        x
        y))
  dispatch)

;; Church Numerals featuring message passing
(define zero
  (lambda (f)
    (lambda (x)
      x)))

(define increment
  (lambda (f)
    (lambda (x)
      (f ((n f) x))))) ; n can be an increment
```

