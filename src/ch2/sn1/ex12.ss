#lang sicp

(#%require rackunit)

;;; Exercise 2.12, page 96

;; Alyssa decided to represent selector and constructor functions like so:

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2))

;; Define a constructor make-center-percent that takes a center and a
;; percentage tolerance and produces the desired interval. You must also define
;; a selector percent that produces the percentage tolerance for a given
;; interval. The center selector is the same as the one shown above.

(define (make-center-percent c p) ; center, percentage of center
  (make-interval (- c (* c (/ p 100.0)))
                 (+ c (* c (/ p 100.0)))))

(define (percent i); interval
  (/ (width i)
     (center i)))

