;; Exercise 1.3
;; Define a procedure that takes three numbers as arguments and returns the sum
;; of the squares of the two larger numbers.

(define (sum-of-two-largest-squares x y z)

  (define (or-equal? operator x y)
    (if (or (operator x y) (= x y))
        #t
        #f))

  (define (middle)
  (cond ((and (or-equal? < y x) (or-equal? < x z)) x)
        ((and (or-equal? < x y) (or-equal? < y z)) y)
        (else z)))

  (define (largest)
    (cond ((and (or-equal? > x y) (or-equal? > x z)) x)
          ((and (or-equal? > y x) (or-equal? > y z)) y)
          (else z)))

  (define (sum-squares a b)

    (define (square number)
      (* number number))
    (+ (square a) (square b)))
  (sum-squares (middle) (largest)))

;; god this code is a cf
