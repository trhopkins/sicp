;;; Exercise 1.33 page 61

;; write a more general form of accumulate (exercise 1.32) that takes an
;; additional predicate function, filter, and combines only values that satisfy
;; its condition.

(define (filter-accumulate combiner
                           null-value
                           term
                           a
                           next
                           b
                           filter) ; pretty printing a bajillion arguments
  (if (> a b)
      null-value
      (if (filter a)
          (combiner (term a)
                    (filter-accumulate combiner
                                       null-value
                                       term
                                       (next a)
                                       next
                                       b
                                       filter))
          (filter-accumulate combiner
                             null-value
                             term
                             (next a)
                             next
                             b
                             filter))))

(define (square n)
  (* n n))

(define (prime? n)
  (define (smallest-div n)
    (define (divides? a b)
      (= 0 (remainder b a)))
    (define (find-div n test)
      (cond ((> (square test) n)
              n)
            ((divides? test n)
              test)
            (else
              (find-div n (+ test 1)))))
    (find-div n 2))
  (if (= n 1)
      #f
      (= n (smallest-div n))))

(define (sum-of-prime-squares a b)
  (define (inc n)
    (+ n 1))
  (filter-accumulate + 0 square a inc b prime?))

