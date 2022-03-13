#lang sicp

(#%require rackunit)

;;; Exercise 1.31, page 60

;; The sum procedure is only the simplest of a vast number of similar
;; abstractions that can be captured in higher-order procedures. Write an
;; analogous procedure called product that returns the values of a function at
;; points over a given range. Show how to define factorial in terms of product.
;; Also use product to compute approximations of pi using the formula:

;;      2 * 4 * 4 * 6 * 6 * ...
;; pi = -----------------------
;;      3 * 3 * 5 * 5 * 7 * ...

;; If your product generates a recursive process, write an iterative one. If it
;; generates an iterative process, write a recursive one.

(define (product term a next b) ; recursive
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (new-product term a next b) ; iterative
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (identity n)
  n)

(define (inc n)
  (+ n 1))

(define (factorial n)
  (new-product identity 1 inc n))

;; pi-sum
(define (pi-sum n)
  (define (pi-term n)
    (/ (* 2 (ceiling (/ (+ n 1) 2)))
       (+ 1 (* 2 (ceiling (/ n 2))))))
  (product pi-term 1 inc n))

(define (approximate-pi n)
  (* 4 (pi-sum n)))

;; demonstration
(define a 1)
(define b 10)
(display (product identity a inc b))
(newline)
(display (new-product identity a inc b))
(newline)
(display (factorial b))
(newline)
(display (approximate-pi 20))
