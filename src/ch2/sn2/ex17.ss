#lang sicp

(#%require rackunit)

;;; Exercise 2.17, page 103

;; Define a procedure last-pair that returns the list that contains only the
;; last element of a given (nonempty) list:

(define (last l)
  (if (null? (cdr l))
      (car l)
      (last (cdr l))))

