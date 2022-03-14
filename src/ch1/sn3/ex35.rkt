#lang sicp

(#%require rackunit)

;;; Exercise 1.35, page 70

;; Show that the golden ratio, phi, is a fixed point of the transformation x ->
;; 1+(1/x). Use this fact to compute phi by means of the fixed-point procedure.

(define tolerance 0.000001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
; 1.618...
