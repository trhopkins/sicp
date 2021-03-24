;;; Exercise 1.17 page 46

;; The exponentiation algorithms in this section are based on performing
;; exponentiation by means of repeated multiplication. In a similar way, one
;; can perform integer multiplication by means of repeated addition. The
;; following multiplication procedure (in which it is assumed that our language
;; can only add, not multiply) is analogous to the expt procedure:

#|
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
|#

;; This algorithm takes a number of steps that is linear to b. Now suppose we
;; include, together with addition, operations double, which doubles an
;; integer, and halve, which divides an (even) integer by two. Using these,
;; design a multiplication procedure analogous to fast-expt that uses a
;; logarithmic number of steps.

;; multiply a and b iteratively
(define (mult a b)
  (define (mult-iter a b n)
    (cond ((= n 0) a)
          ((even? n) (mult-iter a (double b) (halve n)))
          (else (mult-iter (+ a b) b (- n 1)))))
  (mult-iter 0 a b))

;; helper function
(define (halve n)
  (/ n 2))

;; helper function
(define (double n)
  (+ n n))
