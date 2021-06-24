;;; Exercise 2.10, page XXX

;; Ben Bitdiddle, an expert systems programmer, looks over Alyssa's shoulder
;; and comments that it is not clear what it means to divide by an interval
;; that spans zero. Modify Alyssa's code to check for this condition and to
;; signal an error if it occurs.

(load "interval.ss")

(define (div-interval x y) ; page 94
  (define (spans-zero? interval)
    (if (and (negative? (lower-bound interval))
             (positive? (upper-bound interval)))
        #t
        #f))
  (if (spans-zero? y)
      (error "division by zero" y)
      (mul-interval x
                    (make-interval (/ 1.0
                                      (upper-bound y))
                                   (/ 1.0
                                      (lower-bound y)))))

