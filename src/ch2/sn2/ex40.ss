#lang sicp

(#%require rackunit)

;;; Exercise 2.40, page 124

;; Define a procedure unique-pairs that, given an integer n, generates the
;; sequence of pairs (i,j) with 1 < j < i < n. Use unique-pairs to simplify the
;; definition of prime-sum-pairs given above.

(load "../utils.ss")

(define (prime-sum? pair)
  (prime? (+ (car pair)
	     (cadr pair))))

(define (make-prime-sum pair)
  (list (car pair)
	(cadr pair)
	(+ (car pair)
	   (cadr pair))))

(define (prime-sum-pairs n)
  (map (make-prime-sum
	 (filter prime-sum?
		 (flatmap
		   (lambda (i)
		     (map (lambda (j)
			    (list i j))
			  (enumerate-interval 1 (- i 1))))
		   (enumerate-interval 1 n))))))

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map
	(lambda (j)
	  (list i j))
	(enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (unique-primes n)
  (map make-prime-sum
       (filter prime-sum?
	       (unique-pairs n))))

(display (unique-primes 10))

