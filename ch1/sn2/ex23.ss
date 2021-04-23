;;; Exercise 1.23 page 54

;; The smallest-divisor procedure shown at the start of this section
;; does lots of needless testing: After it checks to see if the number
;; is divisible by 2 there is no point in checking to see if it is
;; divisible by any larger even numbers. This suggests that teh values
;; used for test-divisor should not be 2, 3, 4, 5, 6... but rather 2,
;; 3, 5, 7, 9... To implement this change, define a procedure next that
;; returns 3 if its input is equal to 2 and otherwise returns its input
;; plus 2. Modify the smallest-divisor, run the test for each of the 12
;; primes found in exercise 1.22. Since this modification halves the
;; number of test steps, you should expect it to run about twice as
;; fast. Is this expectation confirmed? If not, what is the observed
;; ration of the speeds of the two algorithms, and how do you explain
;; the fact that it is different from 2?

(define (next-three n tup)
  (if (<= 3 (length tup))
      tup
      (if (prime? n)
          (next-three (step n)
                      (cons n tup))
          (next-three (step n)
                      tup))))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? n d)
  (= (remainder d n) 0))

(define (step n)
  (if (even? n)
      (+ n 1)
      (+ n 2)))

(define (square n)
  (* n n))

