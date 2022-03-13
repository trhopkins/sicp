#lang sicp

(#%require rackunit)

;; Extended Exercise: Interval Arithmetic, page 93

;; Representing inexact quantities with known precision: specify a point and
;; variance from that point.

;; Interval: object with lower and upper bound, represented with a pair

(load "ex7.ss")

(define (add-interval x y) ; page 94
  (make-interval (+ (lower-bound x)
                    (lower-bound y))
                 (+ (upper-bound x)
                    (upper-bound y))))

(define (mul-interval x y) ; page 94
  (let ((p1 (* (lower-bound x) ; lower, lower
               (lower-bound y)))
        (p2 (* (lower-bound x) ; lower, upper
               (upper-bound y)))
        (p3 (* (upper-bound x) ; upper, lower
               (lower-bound y)))
        (p4 (* (upper-bound x) ; upper, upper
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) ; handle negatives
                   (max p1 p2 p3 p4))))

(define (div-interval x y) ; page 94
  (mul-interval x
                (make-interval (/ 1.0
                                  (upper-bound y))
                               (/ 1.0
                                  (lower-bound y)))))

