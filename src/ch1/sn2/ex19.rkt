#lang sicp

(#%require rackunit)

;;; Exercise 1.19, page 47

;; There is a clever algorithm for computing the Fibonacci numbers in a
;; logarithmic number of steps... (cut for brevity). Complete the
;; following procedure, which runs in a logarithmic number of steps
;; (find p' and q'):

(define (fib n)
  (define (iter a b p q n)
    (define (even? n)
      (= (remainder n 2) 0))
    (define (square n)
      (* n n))
    (cond ((= n 0) b)
          ((even? n) (iter a
                           b
                           (+ (square p) (square q)) ; p'
                           (+ (* 2 p q) (square q)) ; q'
                           (/ n 2)))
          (else (iter (+ (* b q) (* a q) (* a p))
                      (+ (* b p) (* a q))
                      p
                      q
                      (- n 1)))))
  (iter 1 0 0 1 n))

;; geez this was a difficult one. The lines concerning p' and q' can be
;; found with some linear algebra. Each transformation T is really just
;; the following multiplication:
;;
;; |1 1|
;; |1 0|
;;
;; T_pq can be generalized as the following transformation:
;;
;; |p+q q|
;; |q   p|
;;
;; by squaring this, we get the answer:
;;
;; p' = p^2 + q^2
;; q' = 2pq + q^2
;;
;; applying T_p'q' to a fibonacci matrix applies the operation T_pq
;; twice.

