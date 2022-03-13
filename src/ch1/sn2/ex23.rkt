#lang sicp

(#%require rackunit)

;;; Exercise 1.23, page 54

;; The smallest-divisor procedure shown at the start of this section
;; does lots of needless testing; fix it to only test odd numbers after
;; 2. Does halving the number of potential inputs halve the runtime of
;; the program? Why or why not? Explain.

(define (next-three n tup)
  (if (<= 3 (length tup))
      tup
      (if (prime? n)
          (next-three (step n)
                      (cons n tup))
          (next-three (step n)
                      tup))))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? n d)
  (= (remainder d n) 0))

(define (step n)
  (if (even? n)
      (+ n 1)
      (+ n 2)))

(define (square n)
  (* n n))

