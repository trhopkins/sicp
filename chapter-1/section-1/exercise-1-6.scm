;;; Exercise 1.6
;; Alyssa P. Hacker and Eva Lu Ator defines the following function:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; What will happen when Alyssa uses this new-if function on our sqrt program?

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x) ; CHANGE HERE
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

;; this function will recurse forever since it evaluates the recursive else-clause forever, with no exit condition
