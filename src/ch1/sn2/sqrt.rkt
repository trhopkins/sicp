#lang sicp

(#%require rackunit)

;; lexically scoped square root by Newton's method
(define (sqrt x)
  (define (sqrt-iter guess)
    (define (improve)
      (define (average a b)
        (/ (+ a b) 2))
      (average guess (/ x guess)))
    (define (good-enough?)
      (= guess (improve)))
    (if (good-enough?)
        guess
        (sqrt-iter (improve))))
  (sqrt-iter 1.0))

