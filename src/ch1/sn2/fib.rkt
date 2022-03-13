#lang sicp

(#%require rackunit)

;;; fibonacci example

;; recursive
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1))
         (fib (- n 2)))))

;; linear
(define (f n)
  (f-iter 0 1 n)) ; note lexical scoping here. Consider lambdas?
  (define (f-iter a b n)
    (if (= n 1)
        b
        (f-iter b (+ a b) (- n 1))))

;; look into matrix multiplication version in O(log(N)) time?
;; exercise 1.19?

