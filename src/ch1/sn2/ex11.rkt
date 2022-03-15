#lang sicp

(#%require rackunit)

;;; Exercise 1.11, page 42

;; A function f is defined by the rule that
;; f(n) = n if n < 3 and
;; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3.
;; Write a procedure that computes f by means of an iterative process.

;; recursive version, not correct
(define (f-recur n)
  (if (< n 3)
      n
      (+ (f-recur (- n 1)) ; + is a deferred operation
         (* 2 (f-recur (- n 2)))
         (* 3 (f-recur (- n 3))))))

;; taken from the Scheme Community Wiki after many hours of frustration
(define (f-iter n)
  (if (< n 3)
      n
      (iter 2 1 0 (- n 2))))

(define (iter a b c n)
  (if (zero? n)
      a
      (iter (+ a (* 2 b) (* 3 c)) a b (dec n))))

#;(define (iter a b c n)
  (if (= n 0)
      c
      (iter b c (+ c (* 2 b) (* 3 a)) (- n 1))))

(let ((n 1))
  (check-equal? (f-recur n)
                (f-iter n)))

