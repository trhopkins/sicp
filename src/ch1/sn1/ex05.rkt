#lang sicp

;;; Exercise 1.5, page 21

;; What behavior would you observe from the following functions in
;; normal and applicative order?

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;; p recurses indefinitely. calling test evaluates in applicative
;; order, calling p before resolving test in normal order, p would never
;; be called. if is a normal order procedure.
