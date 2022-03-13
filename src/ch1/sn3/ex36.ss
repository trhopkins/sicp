#lang sicp

(#%require rackunit)

;;; Exercise 1.36, page 70

;; Modify fixed-point so that it prints the sequence of approximations it
;; generates, using the newline and display primitives shown in exercise 1.22.
;; Then find a solution to x^x = 1000 by finding a fixed point of x ->
;; log(1000)/log(x). Compare the number of steps this takes with and without
;; average damping.

(define tolerance 0.000001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess steps)
    ;(display guess)
    ;(newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          (begin ; use cond for this?
            (display steps)
            (newline)
            next)
          (try next (+ steps 1)))))
  (try first-guess 0))

(define target 1000)
(fixed-point (lambda (x)
               (/ (log target)
                  (log x)))
             10.0) ; log(1) is 0

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (average x y)
    (/ (+ x y) 2))
  (define (try guess steps)
    (let ((next (average guess
                         (f guess))))
      (if (close-enough? guess next)
          (begin
            (display steps)
            next)
          (try next (+ steps 1)))))
  (try first-guess 0))

(fixed-point (lambda (x)
               (/ (log target)
                  (log x)))
             10.0)

