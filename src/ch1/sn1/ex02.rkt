#lang sicp

(#%require rackunit)

;; Exercise 1.2, page 21

;; Translate the following expression into prefix form (TikZ).

(check-equal?
 (/ (+ 5
       4
       (- 2
          (- 3
             (+ 6
                (/ 4
                   5)))))
    (* 3
       (- 6
          2)
       (- 2
          7)))
 -37/150)
