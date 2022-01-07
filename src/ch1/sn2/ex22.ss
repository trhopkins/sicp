;;; Exercise 1.22, page 54

;; Most Lisp implementations include a primitive called runtime that
;; returns an integer that specifies the amount of time the system has
;; been running (measured, for example, in microseconds). The following
;; timed-prime-test procedure, when called with an integer n, prints n
;; and checks to see if n is prime. If n is prime, the procedure prints
;; three asterisks followed by the amount of time used in performing the
;; test.

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
  (+ n 1))

(define (square n)
  (* n n))

