;;; Exercise 2.11, page 95

;; In passing, Ben also cryptically comments: 'By testing the signs of the
;; endpoints of the intervals, it is possible to break mul-interval into nine
;; cases, only one of which requires more than two multiplications.' Rewrite
;; this procedure using Ben's suggestion.

(load "interval.ss")

(define (mul-interval x y)
  (define (negative-pair? a b)
    (and (negative? a)
         (negative? b)))
  (define (opposite-pair? a b)
    (or (and (negative? a)
             (positive? b))
        (and (positive? a)
             (negative? b))))
  (define (positive-pair? a b)
    (and (positive? a)
         (positive? b)))
  (let ((lo-x (lower-bound x))
        (hi-x (upper-bound x))
        (lo-y (lower-bound y))
        (hi-y (upper-bound y)))
    (cond ((negative-pair? lo-x hi-x)
            (cond ((negative-pair? lo-y hi-y)
                    (make-interval (* hi-x hi-y)
                                   (* lo-x lo-y)))
                  ((opposite-pair? lo-y hi-y)
                    (make-interval (* lo-x lo-y)
                                   (* lo-x hi-y)))
                  (else ; positive-pair
                    (make-interval (* hi-x lo-y)
                                   (* lo-x hi-y)))))
          ((opposite-pair? lo-x hi-x)
            (cond ((negative-pair? lo-y hi-y)
                    (make-interval (* hi-x lo-y)
                                   (* lo-x lo-y)))
                  ((opposite-pair? lo-y hi-y) ; special case of two opposites
                    (make-interval ((lambda (a b)
                                      (if (< a b) a b)) (* lo-x hi-y) (* hi-x lo-y))
                                   ((lambda (a b)
                                      (if (> a b) a b)) (* lo-x lo-y) (* hi-x hi-y))))
                  (else ; positive-pair
                    (make-interval (* lo-x hi-y)
                                   (* hi-x hi-y)))))
          (else ; positive-pair?
            (cond ((negative-pair? lo-y hi-y)
                    (make-interval (* hi-x lo-y)
                                   (* lo-x hi-y)))
                  ((opposite-pair? lo-y hi-y)
                    (make-interval (* hi-x lo-y)
                                   (* hi-x hi-y)))
                  (else ; positive-pair
                    (make-interval (* lo-x lo-y)
                                   (* hi-x hi-y))))))))

