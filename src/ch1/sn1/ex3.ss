;; Exercise 1.3, page 21

;; Define a procedure that takes three numbers as arguments and returns
;; the sum of the squares of the two larger numbers.

(define (square x)
  (* x x))

(define (sum-squares x y)
  (+ (square x) (square y)))

;; <= operator
(define (less-or-equal? x y)
  (if (or (< x y) (= x y))
      #t
      #f))

;; >= operator
(define (greater-or-equal? x y)
  (if (or (> x y) (= x y))
      #t
      #f))

(define (middle x y z)
  (cond ((and (less-or-equal? y x) (less-or-equal? x z)) x)
        ((and (less-or-equal? x y) (less-or-equal? y z)) y)
        (else z)))

(define (largest x y z)
  (cond ((and (greater-or-equal? x y) (greater-or-equal? x z)) x)
        ((and (greater-or-equal? y x) (greater-or-equal? y z)) y)
        (else z)))

(define (sum-two-largest-squares x y z)
  (sum-squares (middle x y z) (largest x y z)))

