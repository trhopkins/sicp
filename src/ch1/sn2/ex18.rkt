#lang sicp

(#%require rackunit)

;;; Exercise 1.18, page 47

;; Using the results of exercises 1.16 and 1.17, devise a procedure that
;; generates an iterative process for multiplying two integers in terms
;; of adding, doubling, and halving and uses a logarithmic number of
;; steps.

;; god lexical scope is hell sometimes
(define (newer-fast-expt b n) ; Exercise 1.16
  (define (mult a b) ; Exercise 1.17
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

(let ((n 5)
      (e 3))
  (check-equal? (expt n e)
                (newer-fast-expt n e)))

