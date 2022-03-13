#lang sicp

(#%require rackunit)

;;; Exercise 2.15, page 97

;; following from exercise 2.14...

;; Eva Lu Ator, another user, has also noticed the different intervals computed
;; by different but algebraically equivalent expressions. She says that a
;; formula to compute with intervals using Alyssa's system will produce tighter
;; error bounds if it can be written in such a form that no variable that
;; represents an uncertain number is repeated. Thus, she says, par2 is a
;; 'better' program for parallel resistances than par1. Is she right? Why?

;; Eva is right, because introducing more interval values that depend on
;; previously computed values will increase the entropy of the system beyond
;; what it should be. Even in situations where it should cancel things out,
;; like the a/a == 1 example shown earlier, the system cannot tell the true
;; identity of the value given, even if they have the same label, and must be
;; perfectly equal.

