;;; Exercise 1.28, page 56

;; Alternative Fermat's Theorem: if n is prime and a < n, then a^(n-1)
;; mod n is congruent to 1 mod n. Modify the Fermat test to create the
;; Miller-Rabin test, which follows this formula.

(define (expmod base exp m)
  (cond ((= exp 0)
         1)
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
