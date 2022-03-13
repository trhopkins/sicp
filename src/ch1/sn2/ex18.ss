#lang sicp

(#%require rackunit)

;;; Exercise 1.18, page 47

;; Using the results of exercises 1.16 and 1.17, devise a procedure that
;; generates an iterative process for multiplying two integers in terms
;; of adding, doubling, and halving and uses a logarithmic number of
;; steps.

;; ex1-16.ss
(define (new-fast-expt b n)
  (define (mult a b) ; ex1-17.ss
    (define (halve n)
      (/ n 2))
    (define (double n)
      (+ n n))
    (define (mult-iter a b n)
      (cond ((= n 0) a)
            ((even? n) (mult-iter a (double b) (halve n)))
            (else (mult-iter (+ a b) b (- n 1)))))
    (mult-iter 0 a b))
  (define (even? n)
    (= (remainder n 2) 0))
  (define (square x)
    (* x x))
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (square b) (/ n 2)))
          (else (iter (* a b) b (- n 1)))))
  (iter 1 b n))

