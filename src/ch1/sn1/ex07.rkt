#lang sicp

;;; Exercise 1.7, page 25

;; change the sqrt function's good-enough? detector to determine based
;; on percentage difference rather than three decimal places

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

;; once your guesses are too precise to show change, return
(define (good-enough? guess x)
  (= (improve guess x) guess))

(define (improve guess x)
  (average guess (/ x guess)))

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))
