#lang sicp

(#%require rackunit)

;;; Exercise 2.18, page 103

;; Define a procedure reverse that takes a list as argument and returns a list
;; of the same elements in reverse order:

(define (last l)
  (if (null? (cdr l))
      (car l)
      (last (cdr l))))

(define (init l)
  (if (null? (cdr l))
      '()
      (cons (car l) (init (cdr l)))))

;; naive answer, O(n^2)
(define (reverse l)
  (if (null? l)
      '()
      (cons (last l)
            (reverse (init l)))))

;; faster answer, O(n)
(define (reverse l)
  (define (iter l result)
    (if (null? l)
        result
        (iter (cdr l) (cons (car l) result))))
  (iter l '()))

(display (reverse '(1 4 9 16 25)))
; (25 16 9 4 1)

