#lang sicp

(#%require rackunit)

;;; Exercise 1.41, page 77

;; Define a procedure double that takes a procedure of one argument as argument
;; and returns a procedure that applies toe original procedure twice. For
;; example, if inc is a procedure that adds 1 to its argument, then (double
;; inc) should be a procedure that adds 2. What value is returned by:

;; (((double (double double)) inc) 5)

(define (inc n)
  (+ n 1))

(define (double f)
  (lambda (x)
    (f (f x))))

(display (((double (double double)) inc) 5))
;; 21

