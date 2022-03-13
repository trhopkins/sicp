#lang sicp

(#%require rackunit)

;;; Exercise 2.13, page 96

;; Show that under the assumption of small percentage tolerances there is a
;; simple formula for the approximate percentage tolerance of the product of
;; two intervals in terms of the tolerances of the factors. You may simplify
;; the problem by assuming that all numbers are positive.

;; no Scheme, just math. if Ca is the center of a, and Ta is the tolerance of
;; a, a is the interval:

;; a = [Ca*(1 - (1/2)*Ta), Ca*(1 + (1/2)*Ta)]
;; b = [Cb*(1 - (1/2)*Tb), Cb*(1 + (1/2)*Tb)]
;; a*b = [Ca*Cb*(1 - (1/2)*(Ta + Tb) + (1/4)*Ta*Tb),
;;        Ca*Cb*(1 + (1/2)*(Ta + Tb) + (1/4)*Ta*Tb)]

;; a*b's interval tolerance, Tab, will be very very small. Special thanks to
;; the Community Scheme Wiki.

