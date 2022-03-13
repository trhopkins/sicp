#lang sicp

(#%require rackunit)

;;; Exercise 1.29, page 60

;; Simpson's rule: approximate numerical integrals as follows:
;; (h/3)(y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 4y_n-1 + y_n)
;; where h = (b - a) / n, and y_k = f(a + kh).
;; Increasing n increases accuracy. Compute the cube root of x from 0
;; to 1, with n = 100 and n = 1000.

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define dx 0.000001) ; convert to let?

(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpson f a b n)
  (define h (/ (- b a) n)) ; replace with let?
  (define (y k) ; general y subscript k
    (f (+ a (* k h))))
  (define (y-pair k) ; evens only
    (+ (* 2 (y k))
       (* 4 (y (+ k 1)))))
  (define (add2 k)
    (+ k 2))
  (* (/ h 3) ; put it all together
     (+ (sum ypair 0 add2 (- n 1))
        (- (f b)
           (f a)))))

