#lang sicp

(#%require rackunit)

;;; Exercise 2.35, page 120

;; Redefine count-leaves from section 2.2.2 as an accumulation:

#;(define (count-leaves t)
  (accumulate <??> <??> (map <??> <??>)))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (t)
                     (if (not (pair? t))
                         1
                         (count-leaves-recursive t)))
                   t)))

