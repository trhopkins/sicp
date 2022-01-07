;;; Exercise 2.3, page 90

;; Implement a representation for rectangles in a plane. Write a procedure that
;; computes the perimeter and the area of a given rectangle. Can you design
;; your system so the same perimeter and area procedures will work for either
;; representation?

(define (make-point x y) ; two numbers
  (cons x y))

(define (x-point point) ; returns number
  (car point))

(define (y-point point) ; returns number
  (cdr point))

(define (make-rectangle top-left bottom-right) ; construct a rectangle
  (cons top-left bottom-right))

(define (height rectangle) ; get the height of a rectangle
  (- (y-point (car rectangle))
     (y-point (cdr rectangle))))

(define (width rectangle) ; get the width of a rectangle
  (- (x-point (car rectangle))
     (x-point (cdr rectangle))))

(define (perimeter rectangle) ; get the perimeter of a rectangle
  (+ (* 2 (width rectangle))
     (* 2 (area rectangle))))

(define (area rectangle) ; get the area of a rectangle
  (* (width rectangle)
     (height rectangle)))

(define (make-rectangle2 bottom-left top-right)
  (cons bottom-left top-right))

(define (height2 rectangle) ; get the height of a rectangle
  (- (x-point (car rectangle))
     (x-point (cdr rectangle))))

(define (width2 rectangle) ; get the width of a rectangle
  (- (y-point (car rectangle))
     (y-point (cdr rectangle))))

