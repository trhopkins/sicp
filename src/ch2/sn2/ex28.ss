#lang sicp

(#%require rackunit)

;;; Exercise 2.28, page 111

;; Write a procedure fringe that takes as argument a tree (represented as a
;; list) and returns a list whose elements are all the leaves of the tree
;; arranged in left-to-right order. For example,

(define x (list (list 1 2) (list 3 4)))
(set! x '((1 2) (3 4)))

; (fringe x)
; (1 2 3 4)

; (fringe (list x x))
; (1 2 3 4 1 2 3 4)

;; AKA flatten
(define (fringe t)
  (define (iter t res) ; tree, result
    (cond
      ((null? t)
        res)
      ((not (pair? t))
        (cons t res))
      (else
        (iter (car t) (iter (cdr t) res)))))
  (iter t '()))

(display (fringe x))

(display (fringe (list x x)))

