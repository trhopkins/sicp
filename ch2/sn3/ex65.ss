;;; Exercise 2.65

;; Use the results of exercises 2.63 and  2.64 to give O(n) implementations of
;; union and intersection for sets implemented as (balanced) binary trees.

(load "ex64.ss")

(define (union a b)
  (cond
    ((null? a) ; tested before left/right are called
      b)
    ((null? b)
      a)
    (else
      (let ((a-root (root a)) ; consider removing helper defs?
            (a-left (left a))
            (a-right (right a))
            (b-root (root b))
            (b-left (left b))
            (b-right (right b)))
        (cond ; reminiscent of ordered list
          ((= a-root b-root)
            (make-tree ; O(1) operation repeated n times
              a-root
              (union a-left b-left)
              (union a-right b-right)))
          ((< a-root b-root)
            (make-tree
              b-root
              (union a b-left)
              b-right))
          (else ; a-root > b-root
            (make-tree
              a-root
              (union a-left b)
              a-right)))))))

;; TODO: implement intersection

(let ((a (list->tree '(1 3 5 7 9)))
      (b (list->tree '(1 3 7 10))))
  (display (union a b)))
