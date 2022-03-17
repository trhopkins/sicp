#lang sicp

(#%require rackunit)

;;; Example from page 40

;; How many ways can you calculate change for n cents?
;; Assume you can only use quarters, nickels, dimes, and pennies

(define (count-change amount)
  (cc amount 4))

(define (cc amount kinds-of-coins)
  (cond ((zero? amount) 1) ; cannot reduce further, valid answer reached
        ((or (< amount 0) (zero? kinds-of-coins)) 0) ; invalid answer
        (else (+ (cc amount ; try current amount with smaller coins
                     (dec kinds-of-coins))
                 (cc (- amount ; try subtract current amount by coin
                        (denom kinds-of-coins))
                     kinds-of-coins)))))

(define (denom kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)    ; penny
        ((= kinds-of-coins 2) 5)    ; nickel
        ((= kinds-of-coins 3) 10)   ; dime
        ((= kinds-of-coins 4) 25)   ; quarter
        ((= kinds-of-coins 5) 50))) ; half-dollar

