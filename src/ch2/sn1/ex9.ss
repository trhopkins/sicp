;;; Exercise 2.9, page 95

;; The width of an interval is half the difference between its upper and lower
;; bounds. Show that the width of the sum (or difference) of two intervals is a
;; function of of the widths of the two intervals being added (or subtracted).
;; Give examples to show that this is not true for multiplication or division.

(load "ex7.ss")
(load "interval.ss")

(define (interval-width interval)
  (- (upper-bound interval)
     (lower-bound interval)))

(define (certainty interval)
  (/ interval-width 2.0))

(define a (make-interval 100 150))
(define b (make-interval 20 75))

;; print interval addition
(display a)
(display " + ")
(display b)
(display " = ")
(display (add-interval a b))
(newline)

;; print interval width addition
(display (interval-width a))
(display " + ")
(display (interval-width b))
(display " = ")
(display (interval-width (add-interval a b))) ; correct sum
(newline)

;; print interval multiplication
(display a)
(display " * ")
(display b)
(display " = ")
(display (mul-interval a b))
(newline)

;; print interval width multiplication
(display (interval-width a))
(display " * ")
(display (interval-width b))
(display " = ")
(display (interval-width (mul-interval a b))) ; should say 2750, instead 9250
(newline)

