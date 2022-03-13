#lang sicp

(#%require rackunit)

;;; Exercise 2.8, page 95

;; Describe how the difference of two intervals may be computed with a
;; subtraction procedure, sub-interval.

(load "ex7.ss") ; basic pair abstraction

(define (sub-interval x y)
  (make-interval (- (lower-bound x)
                    (lower-bound y))
                 (- (upper-bound x)
                    (upper-bound y))))

