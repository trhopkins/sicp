#lang sicp

(#%require rackunit)

;;; Exercise 1.34 page 66

;; Suppose we have a procedure:

(define (f g)
  (g 2))

;; Then we have:

(f square)
; 4

(f (lambda (z) (* z (+ z 1))))
; 6

;; What happens if we perversely as the interpreter to evaluate the combination
;; (f f)? Explain.

;; (f f)
;; (f 2)
;; (2 2)
;; applying a function to a number doesn't make sense, so an exception is
;; raised.

