#lang sicp

(#%require rackunit)

;;; Exercise 2.7, page 94

;; Define constructors and selectors for our early interval abstraction

(define (make-interval x y)
  (cons x y))

(define (make-interval x y)
  (if (< a b)
      (cons a b)
      (cons b a)))

(define (make-interval x y)
  (cons x y))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

