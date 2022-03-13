#lang sicp

(#%require rackunit)

;;; Exercise 1.46, page 78

;; Write a procedure iterative-improve that takes a procedure to test whether a
;; guess is good enough and a procedure to improve that guess. Rewrite sqrt and
;; fixed-point in terms of iterative-improve.

(define (iterative-improve test f)
  (lambda (guess)
    (if (test guess)
        guess
        ((iterative-improve test f) (f guess)))))

(define (close-enough? x y)
  (let ((tolerance 0.00001))

(define (sqrt x)
      (< (abs (- x y)) tolerance)))
  (define (average x y)
    (/ (+ x y) 2))
  ((iterative-improve close-enough?
                      (lambda (y)
                        (average y (/ x y))))
   x))

(define (fixed-point f)
  ((iterative-improve (lambda (x)
                        (close-enough? x (f x)))
                      f)))

