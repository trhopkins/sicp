#lang sicp

(#%require rackunit)

;;; Exercise 2.41, page 124

;; Write a procedure to find all ordered triples of distinct positive integers
;; i, j, and k less than or equal to a given integer n that sum to a given
;; integer s.

(load "../utils.ss")

(define (unique-triples n)
  (flatmap
    (lambda (i)
      (flatmap
	(lambda (j)
	  (map
	    (lambda (k)
	      (list i j k))
	    (enumerate-interval 1 (- j 1))))
	(enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (triples-adding-to n triple)
  (filter (lambda (t)
	    (= (accumulate + 0 t) n))
	  triple))

(display (triples-adding-to 15 (unique-triples 10)))
#;(display (unique-triples 5))

