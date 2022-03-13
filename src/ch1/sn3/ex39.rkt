#lang sicp

(#%require rackunit)

;;; Exercise 1.39, page 72

;; A continued fraction representation of the tangent function was published in
;; 1770 by the German mathematician J. H. Lambert: (TikZ...)

;; ...where x is in radians. Define a procedure (tan-cf x k) that computes an
;; approximation to the tangent function based on Lambert's formula. K
;; specifies the number of terms to compute, as in exercise 1.37.

(define (cont-frac n d k)
  (define (frac-rec i)
    (/ (n i)
       (- (d i) ; subtract instead of add
          (if (> i k)
              0
              (frac-rec (+ i 1))))))
  (frac-rec 1))

(define (tan-cf x k)
  (/ (cont-frac (lambda (i)
                  (* x x))
                (lambda (i)
                  (- (* i 2) 1))
                k)
     x))

(display (tan-cf 60.0 100))
