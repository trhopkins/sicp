#lang sicp

(#%require rackunit)

;;; Exercise 1.12, page 42

;; The following pattern of numbers is called Pascal's Triangle.

;;#|
;;1 | 1
;;2 | 1  1
;;3 | 1  2  1
;;4 | 1  3  3  1
;;5 | 1  4  6  4  1
;;6 | 1  5  10 10 5  1
  ;;+ ----------------
    ;;1  2  3  4  5  6
;;|#

;; The numbers at each edge of the triangle are 1, and each number
;; inside is the sum of the two numbers above it. Write a procedure that
;; computes the elements of Pascal's Triangle by means of a recursive
;; process.

#;(define (pascal row col) ; only works for values included in triangle
  (if (or (= row col) (= col 1))
      1
      (+ (pascal (dec row) col)
         (pascal (dec row) (dec col)))))

(define (pascal row col) ; works for values outside of triangle (all zero)
  (cond ((or (> col row) (<= col 0))
         0)
        ((or (= row col) (= col 1))
         1)
        (else
          (+ (pascal (dec row) col)
             (pascal (dec row) (dec col))))))

(check-equal? (pascal 4 2)
              3)

(check-equal? (pascal 4 6)
              10)

