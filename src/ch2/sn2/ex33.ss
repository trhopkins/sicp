#lang sicp

(#%require rackunit)

;;; Exercise 2.33, page 119

;; Fill in the missing expressions to complete the following definitions of
;; some basic list-manipulation operations as accumulations:

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              '()
              sequence))

(define (append seq1 seq2)
  (accumulate cons
              seq2
              seq1))

(define (length sequence)
  (accumulate (lambda (x y)
                (+ y 1))
              0
              sequence))

(display (append '(1 2 3) '(4 5 6)))
(newline)
(display (length '(1 2 3 4 0)))
(newline)
(display (map (lambda
                (x) (+ x 1))
              '(1 2 3)))

