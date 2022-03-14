#lang sicp

(#%require rackunit)

;;; Example from, page 40

;; How many ways can you calculate change for n cents?
;; Assume you can only use quarters, nickels, dimes, and pennies

(define (count-change amount)
  (cc amount 4)) ; set to 5 if using half-dollars

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
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
        ;((= kinds-of-coins 5) 50))) ; half dollar, deprecated currency
