#lang sicp

(#%require rackunit)

;;; Exercise 2.54, page 145

;; Two lists are said to be equal? if they contain equal elements arranged in
;; the same order. For example,

(equal? '(this is a list) '(this is a list))

;; is true, but

(equal? '(this is a list) '(this (is a) list))

;; is false. To be more precise, we can define equal? recursively in terms of
;; the basic eq? equality of symbols by saying that a and b are equal? if they
;; are both symbols and the symbols are eq?, or if they are both lists such
;; that (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b). Using
;; this idea, implement equal? as a procedure.

(define (equal? a b)
  (cond ((and (null? a) ; null & null
	      (null? b))
	  #t)
	((or (null? a) ; null & !null
	     (null? b))
	  #f)
	((and (not (pair? a)) ; atom & atom
	      (not (pair? b)))
	  (cond ((and (symbol? a) ; symbol & symbol. Consider eqv? here?
		      (symbol? b))
		  (eq? a b))
		((and (number? a) ; number & number
		      (number? b))
		  (= a b))
		(else ; symbol & number
		  #f)))
	((or (not (pair? a)) ; atom & pair
	     (not (pair? b)))
	  #f)
	(else ; pair & pair
	  (and (equal? (car a) ; typical element
		       (car b))
	       (equal? (cdr a) ; natural recursion
		       (cdr b))))))

(display (equal? '(a 1 (c)) '(a 1 (c))))

