;;; Exercise 1.32, page 60

;; Show that sum and product (exericse 1.31) are both special cases of a still
;; more general notion called accumulate that combines a collection of terms,
;; using some general accumulation function:

;; (accumulate combiner null-value term a next b)

;; Also use a combiner procedure with two arguments that specifies how the
;; current item is to be combined with the accumulation of the preceding terms
;; and a null-value that specifies what base value to use when the terms run
;; out. Write accumulate and show how sum and product can both be defined as
;; simple calls to accumulate.

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
               (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

;; If your accumulate process generates a recursive process, write an iterative
;; one. If your accumulate process generates an iterative process, write a
;; recursive one.

(define (new-accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (new-sum term a next b)
  (new-accumulate + 0 term a next b))

(define (new-product term a next b)
  (new-accumulate * 1 term a next b))

