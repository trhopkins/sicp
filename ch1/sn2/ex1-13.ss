;;; Exercise 13 page 42

;; Prove that Fib(n) is the closest integer to (psi^n)/sqrt(5) where psi = (1 +
;; sqrt(5))/2.  Hint: let phi = (1 - sqrt(5))/2. Use induction and the
;; definition of the Fibonacci numbers (see section 1.2.2) to prove that Fib(n)
;; = (psi^n - phi^n)/sqrt(5).

;; Fibonacci sequence
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 1)
        b
        (fib-iter b (+ a b) (- count 1))))
  (fib-iter 0 1 n))

(define psi (/ (+ 1 (sqrt 5)) 2))
(define phi (/ (- 1 (sqrt 5)) 2)) ; hint, may not be needed

;; get number closest to psi^n/sqrt(5), compare to Fib(n)
(define (closest? p f)
  (if (<= (abs (- p f)) .5)
      #t
      #f))

(define (power a b)
  (define (power-iter a total count)
    (if (= count 0)
        total
        (power-iter a (* a total) (- count 1))))
  (power-iter a 1 b))


;; lexically scoped square root by Newton's method
(define (sqrt x) ; consider lambdas here later?
  (define (sqrt-iter guess)
    (define (improve)
      (define (average a b)
        (/ (+ a b) 2))
      (average guess (/ x guess)))
    (define (good-enough?)
      (= guess (improve)))
    (if (good-enough?)
        guess
        (sqrt-iter (improve))))
  (sqrt-iter 1.0))

;; proof for some n
(define (compare-all n)
  (if (closest? (/ (power psi n) (sqrt 5)) (fib n))
      (display "yes")
      (display "no"))
  (if (= n 0)
      #f
      (compare-all (- n 1))))

;(compare-all 5)

(if (closest? (/ (power psi 10) (sqrt 5)) (fib 10))
    (display "yes\n")
    (display "no"))

(define (asdf n)
  (cond ((= n 0) (display "end"))
        ((not (= n 0)) (display "not done\n")
                       (asdf (- n 1)))))
(asdf 3)

;; NOT DONE, CLEAN UP CODE
