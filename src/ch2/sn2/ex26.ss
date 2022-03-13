#lang sicp

(#%require rackunit)

;;; Exercise 2.26, page 110

;; Suppose we define x and y to be two lists:

(define x (list 1 2 3))
(define y (list 4 5 6))

;; What result is printed by the interpreter in response to evaluating each of
;; the following expressions:

(define (append s l)
  (if (null? l)
      (list s)
      (cons (car l)
            (append s (cdr l)))))

(display (append x y))
; (4 5 6 (1 2 3))

(display (cons x y))
; ((1 2 3) 4 5 6)

(display (list x y))
; ((1 2 3) (4 5 6))

