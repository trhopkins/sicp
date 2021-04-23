;;; Exercise 1.24, page 55

;; Modify the timed-prime-test procedure of exercise 1.22 to use
;; fast-prime?  (the Fermat method), and test each of the 12 primes you
;; found in that exercise. Since the Fermat test as O(log(n)) growth,
;; how would you expect the time to sometimes near 1,000,000 to compare
;; with the time needed to test primes near 1,000? Does your data bear
;; this out? Can you explain any discrepancy you find?

(define (next-three n tup)
  (if (<= 3 (length tup))
      tup
      (if (fast-prime? n 1)
          (next-three (step n)
                      (cons n tup))
          (next-three (step n)
                      tup))))

(define (step n)
  (if (even? n)
      (+ n 1)
      (+ n 2)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (square n)
  (* n n))

