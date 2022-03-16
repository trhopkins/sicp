#lang sicp

(#%require rackunit)

;;; Exercise 1.13, page 42

;; Prove that Fib(n) is the closest integer to (psi^n)/sqrt(5) where psi
;; = (1 + sqrt(5))/2.  Hint: let phi = (1 - sqrt(5))/2. Use induction
;; and the definition of the Fibonacci numbers (see section 1.2.2) to
;; prove that Fib(n) = (psi^n - phi^n)/sqrt(5).

;; Fibonacci sequence
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 1)
        b
        (fib-iter b (+ a b) (dec count))))
  (fib-iter 0 1 n))

;; lexically scoped square root by Newton's method, used for psi/phi
(define (sqrt x)
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

(define psi (/ (+ 1 (sqrt 5)) 2))
(define phi (/ (- 1 (sqrt 5)) 2)) ; hint, may not be needed

;; get number closest to psi^n/sqrt(5), compare to Fib(n)
#;(define (closest? psi fib)
  (<= (abs (- psi fib)) .5))

#;(define (check-all n)
  (if (zero? n)
      'done
      (begin
        (check-true (closest? (/ (expt psi 10) (sqrt 5)) (fib 10)))
        (check-all (dec n)))))

#;(check-all 10)

(let* ((n 10)
       #;(req (/ (expt psi n) (sqrt 5))) ; initial test
       (req (/ (- (expt psi n)
                  (expt phi n))
               (sqrt 5))) ; sci-fi test
       (res (fib n)))
  (check-= req res 0.001))

