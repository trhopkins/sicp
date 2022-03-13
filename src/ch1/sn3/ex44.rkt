#lang sicp

(#%require rackunit)

;;; Exercise 1.44, page 77

;; The idea of smoothing a function is an important concept in signal
;; processing. If f is a function and dx is some small number, then the
;; smoothed version of f is the function whose value at a point x is the
;; average of f(x-dx), fx, and f(x+dx). Write a procedure smooth that takes as
;; input a procedure that computes f and returns a procedure that computes the
;; smoothed f. It is sometimes valuable to repeatedly smooth a function (that
;; is, smooth the smoothed function, and so on) to obtain the n-fold smoothed
;; function.  Show how to generate the n-fold smoothed function of any given
;; function using smooth and repeated from exercise 1.43.

(define dx 0.00001)


(define (compose2 f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose2 f (repeated f (- n 1)))))

(define (smooth f n)
  (define (average3 a b c)
    (/ (+ a b c)
       3))
  (define (smooth-iter)
    (average3 (f (+ x dx))
              (f x)
              (f (- x dx))))
  ((repeated smooth f) n))

