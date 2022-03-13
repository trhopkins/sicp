#lang sicp

(#%require rackunit)

;;; Exercise 2.2, page 89

;; Define a representation for line segments on a plane. Each segment is
;; represented as a pair of points, and each point is a pair of numbers (an x
;; and y value). Specify constructors/selectors as necessary. Use them to write
;; a midpoint procedure, and a way to print point and line segments.

(define (make-point x y) ; two numbers
  (cons x y))

(define (x-point point) ; returns number
  (car point))

(define (y-point point) ; returns number
  (cdr point))

(define (make-segment start end) ; two points
  (cons start end))

(define (start-segment segment) ; returns point
  (car segment))

(define (end-segment segment) ; returns point
  (cdr segment))

(define (display-point point)
  (display #\()
  (display (x-point point))
  (display ", ")
  (display (y-point point))
  (display #\)))

(define (display-segment segment)
  (display-point (start-segment segment))
  (display " to ")
  (display-point (end-segment segment))
  (newline))

(define (midpoint-segment segment)
  (define (average x y)
    (/ (+ x y)
       2.0))
  (let ((x-position (average (x-point (start-segment segment))
                             (x-point (end-segment segment))))
        (y-position (average (y-point (start-segment segment))
                             (y-point (end-segment segment)))))
    (make-point x-position y-position)))

(define start (make-point 0 1))
(define end (make-point 0 5))
(define segment (make-segment start end))
#;(display-point start)
(display-segment segment)

