#lang sicp

(#%require rackunit)

;;; Exercise 2.55, page 145

;; Eva Lu Ator types to the interpreter the expression

(car ''abracadabra)

;; To her surprise, the interpreter prints back quote. Explain. 

;; the expression (car ''abracadabra) desugars (expands) to (car (quote (quote
;; abracadabra))). The car of (quote (quote abracadabra)) is quote.

