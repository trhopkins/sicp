#lang sicp

(#%require rackunit)

;;; Exercise 2.64, page 159

;; The following procedure list->tree converts an ordered list to a balanced
;; binary tree. The helper procedure partial-tree takes as arguments an integer
;; n and list of at least n elements and constructs a balanced tree containing
;; the first n elements of the list. The result returned by partial-tree is a
;; pair (formed with cons) whose car is the constructed tree and whose cdr is
;; the list of elements not included in the tree.

(load "ex63.ss")

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n) ; rewritten with let*
  (if (zero? n)
      (cons '() elts)
      (let* ((left-size (quotient (- n 1) 2))
             (left-result (partial-tree elts left-size))
             (left-tree (car left-result))
             (non-left-elts (cdr left-result))
             (right-size (- n (+ left-size 1)))
             (this-entry (car non-left-elts))
             (right-result (partial-tree (cdr non-left-elts) right-size))
             (right-tree (car right-result))
             (remaining-elts (cdr right-result)))
        (cons (make-tree this-entry left-tree right-tree)
              remaining-elts))))

;; a. Write a short paragraph explaining as clearly as you can how partial-tree
;; works. Draw the tree produced by list->tree for the list (1 3 5 7 9 11).

;; partial-tree splits the list elts into three parts: the median, items
;; greater than, and items less than that median. It then creates a
;; partial-tree starting with the median as the root, the lesser items as the
;; left subtree, and the greater items as the right subtree.

;;    5
;;  /   \
;; 1     9
;;  \   / \
;;   3 7  11

;; b. What is the order of growth in the number of steps required by list->tree
;; to convert a list of n elements?

;; each subtree is a make-tree, which is O(n). Each partial-tree requires a
;; length which halves each time, which is O(n/2). This is doubled (once for
;; each subtree), so the total would be 2O(n/2).

;; According to the Master Theorem, a = 2, and b = 2, so T(n) = O(n), or linear
;; time.

