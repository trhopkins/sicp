#lang sicp

(#%require rackunit)

;;; Chapter 2 utility functions

;; page 103
(define (append l1 l2)
  (if (null? l1)
      l2
      (cons (car l1)
            (append (cdr l1) l2))))

;; page 105
(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

;; page 107
(define (for-each f l)
  (if (not (null? l))
      (begin
        (f (car l))
        (for-each f (car l)))))

;; page 113
(define (tree-map f t)
  (cond
    ((null? t)
      '())
    ((not (pair? t))
      (f t))
    (else
      (cons (tree-map f (car t))
            (tree-map f (cdr t))))))

;; page 115
(define (filter test? l)
  (cond
    ((null? l)
      '())
    ((test? (car l))
      (cons (car l)
            (filter test? (cdr l))))
    (else
      (filter test? (cdr l)))))

;; page 116
(define (accumulate f init l)
  (if (null? l)
      init
      (f (car l)
         (accumulate f init (cdr l)))))

(define fold-right accumulate) ; more like Haskell's foldr

;; page 121
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))

;; page 116
(define (enumerate-interval lo hi)
  (if (> lo hi)
      '()
      (cons lo
            (enumerate-interval (+ lo 1) hi))))

;; page 116
(define (enumerate-tree t)
  (cond
    ((null? t)
      '())
    ((not (pair? t))
      (list t))
    (else
      (append (enumerate-tree (car t))
              (enumerate-tree (car t))))))

;; page 123
(define (flatmap proc seq)
  (accumulate append
	      '()
	      (map proc seq)))

;; page 124
(define (remove item seq) ; removes all instances
  (filter (lambda (x)
	    (not (= x item)))
	  seq))

;; page 124
(define (permutations s)
  (if (null? s)
      '(()) ; sequence containing the empty set
      (flatmap
	(lambda (x)
	  (map (lambda (p)
		 (cons x p))
	       (permutations (remove x s))))
	s)))

;; page 125
(define (prime? n)
  (define (test? divisor)
    (cond
      ((> (* divisor divisor) n)
        #t)
      ((= (remainder n divisor) 0)
        #f)
      (else
	(test? (+ divisor 1)))))
  (test? 2))

