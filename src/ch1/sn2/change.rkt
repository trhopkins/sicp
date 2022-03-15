#lang sicp

(#%require rackunit)

;;; Example from page 40

;; How many ways can you calculate change for n cents?
;; Assume you can only use quarters, nickels, dimes, and pennies

(define (count-change amount)
  (cc amount 4))

(define (cc amount kinds-of-coins)
  (cond ((zero? amount) 1)
        ((or (< amount 0) (zero? kinds-of-coins)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)))

