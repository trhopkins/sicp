;;; Exercise 2.62, page 155

;; Give a (n) implementation of union-set for sets represented as ordered
;; lists.

(load "ex61.ss")

(define (union-list set1 set2) ; O(n) merge from merge-sort
  (cond
    ((null? set1)
      set2)
    ((null? set2)
      set1)
    (else
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond
          ((> x1 x2)
            (cons x2 (union-list set1 (cdr set2))))
          ((< x1 x2)
            (cons x1 (union-list (cdr set1) set2)))
          (else ; x1 == x2
            (cons x1 (union-list (cdr set1) (cdr set2)))))))))

