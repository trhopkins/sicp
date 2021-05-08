;;; Exercise 1.30, page 60

;; The given sum definition creates a recursive function. Rewrite it as an
;; iterative function.

(define (sum term a next b) ; recursive
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (new-sum term a next b) ;; iterative
  (define (iter a result) ; lexically-scoped iter
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

;; remaining driver functions to confirm correctness

(define (square n)
  (* n n))

(define (identity n)
  n)

(define (inc n)
  (+ n 1))

(define a 1)
(define b 5)

(display (sum identity a inc b))
(newline)
(display (new-sum identity a inc b))
