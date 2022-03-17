#lang sicp

(#%require rackunit)

;;; Exercise 1.16, page 46

;; Design a procedure that evolves an iterative exponentiation process
;; that uses successive squaring and uses a logarithmic number of steps,
;; as does fast-expt.

;; Hint: (b^(n/2))^2 = (b^2)^(n/2). Add state variable a, such that ab^n
;; is unchanged state to state

;; recursive implementation, page 45
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1)))))) ; * is not a tail call!

;; iterative implementation
(define (new-fast-expt b n)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (square b) (/ n 2)))
          (else (iter (* a b) b (- n 1)))))
  (iter 1 b n))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))

(let ((n 5)
      (e 3))
  (check-equal? (fast-expt n e)
                (new-fast-expt n e)))

