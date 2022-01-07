;;; Exercise 1.11, page 42

;; A function f is defined by the rule that
;; f(n) = n if n < 3 and
;; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3.
;; Write a procedure that computes f by means of an iterative process.

;; recursive version, not correct
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) ; + is a deferred operation
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

;; taken from ivanjovanovic/sicp after many hours of frustration
(define (f n)
  (if (< n 3)
      n
      (f-iter 0 1 2 n))

(define (f-iter a b c n)
  (if (= n 0)
      c
      (f-iter b c (+ c (* 2 b) (* 3 a)) (- n 1))))

