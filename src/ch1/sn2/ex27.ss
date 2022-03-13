#lang sicp

(#%require rackunit)

;;; Exercise 1.27, page 55

;; Demonstrate that the Carmichael numbers listed in footnote 47 really
;; do fool the Fermat test. That is, write a procedure that takes an
;; integer n and tests whether a^n is congruent to a modulo n for every
;; a < n, and try your procedure on the given Carmichael numbers.

(define (expmod base exp m)
  (cond ((= exp 0)
         1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (carmichael? n)
  (define (car-iter n a)
    (cond ((or (= n 0) (= n 1))
           #f)
          ((= a n)
           #t) ; find a clearer indentation strategy for this? TLS?
          ((not (= (expmod a n n)
                   (remainder a n)))
           #f)
          (else
           (car-iter n (+ a 1)))))
  (car-iter n 1))

(define (square n)
  (* n n))

