#lang sicp

(#%require rackunit)

;;; Exercise 1.10, page 36

;; The following procedure computes a mathematical function known as
;; Ackermann's function.

(define (A x y)
  (cond ((zero? y) 0)
        ((zero? x) (* 2 y))
        ((= y 1) 2)
        (else (A (dec x)
                 (A x (dec y))))))

;; What are the values of the following expressions?

(check-equal? (A 1 10)
              1024)

(check-equal? (A 2 4)
              65536)

(check-equal? (A 3 3)
              65536)

;; Consider the following procedures, where A is the procedure defined
;; above:

(define (f n) (A 0 n))

(define (g n) (A 1 n))

(define (h n) (A 2 n))

(define (k n) (* 5 n n))

;; Give concise mathematical definitions for the functions computed by
;; the procedures f, g, and h for positive integer values of n. For
;; example, (k n) computes 5n^2.

(define (knuth n) ; knuth-arrow n. Next step beyond exponentiation
  (define (iter a n)
    (if (zero? n)
        a
        (iter (expt 2 a) (dec n))))
  (iter 1 n))

(let ((n 5))
  (check-equal? (f n) ; = 2n
                (* 2 n))
  (check-equal? (g n) ; = 2^n
                (expt 2 n))
  (check-equal? (h n) ; = 2 knuth-arrow n
                (knuth n))
  (check-equal? (k n) ; = 5n^2
                (* 5 (expt n 2))))

