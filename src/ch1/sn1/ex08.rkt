#lang sicp

;;; Exercise 1.8, page 26

;; Newton's method for cube root

(define (cube-root x)
  (cube-root-iter 1.0 x))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x)
                      x)))

(define (good-enough? guess x)
  (= (improve guess x) guess))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (square x)
  (* x x))
