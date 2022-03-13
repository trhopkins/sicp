#lang sicp

(#%require rackunit)

;;; Exercise 2.65

;; Use the results of exercises 2.63 and  2.64 to give O(n) implementations of
;; union and intersection for sets implemented as (balanced) binary trees.

(load "ex62.ss") ; ordered lists

(load "ex64.ss") ; binary trees

#;(define (intersection set1 set2)
  (cond
    ((null? set1)
      '())
    ((null? set2)
      '())
    (else
      (list->tree (intersection-list (tree->list set1)
                                     (tree->list set2))))))

(define (union set1 set2)
  (cond
    ((null? set1)
      set2)
    ((null? set2)
      set1)
    (else
      (list->tree (union-list (tree->list set1)
                              (tree->list set2))))))

;; TODO: fix intersection

#;(let ((a (list->tree '(1 3 5 7 9)))
      (b (list->tree '(1 3 7 10))))
  (display (intersection a b)))

(let ((a (list->tree '(1 3 5 7 9)))
      (b (list->tree '(1 3 7 10))))
  (display (union a b)))

