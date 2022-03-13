#lang sicp

(#%require rackunit)

;;; Exercise 2.31, page 113

;; Abstract your answer to exercise 2.30 to produce a procedure tree-map with
;; the property that square-tree could be defined as

#;(define (square-tree tree)
  (tree-map square tree))

(define (tree-map f t)
  (cond
    ((null? t)
      '())
    ((not (pair? t))
      (f t))
    (else
      (cons (tree-map f (car t))
            (tree-map f (cdr t))))))

(display (tree-map (lambda (x) (* x x))
                   '(1 (2 (3 4) 5) (6 7))))

