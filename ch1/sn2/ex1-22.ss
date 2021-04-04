;;; Exercise 1.22 page 54

;; Most Lisp implementations include a primitive called runtime that
;; returns an integer that specifies the amount of time the system has
;; been running (measured, for examplle, in microseconds). The
;; following timed-prime-test procedure, when called with an integer n,
;; prints n and checks to see if n is prime. If n is prime, the
;; procedure prints three asterisks followed by the amount of time used
;; in performing the test.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display "***")
  (display elapsed-time))

;; exercise 1.22 is not possible with Chez Scheme. Consider #lang sicp
;; in DrRacket? Also use larger numbers since modern computers are so
;; much faster than they were back in 1996. UNFINISHED
