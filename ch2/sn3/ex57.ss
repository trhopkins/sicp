;;; Exercise 2.57, page 151

;; Extend the differentiation program to handle sums and products of arbitrary
;; numbers of (two or more) terms. Then the last example above could be
;; expressed as

;; (deriv '(* x y (+ x 3)) 'x)

;; Try to do this by changing only the representation for sums and products,
;; without changing the deriv procedure at all. For example, the addend of a
;; sum would be the first term, and the augend would be the sum of the rest of
;; the terms.

(load "../utils.ss") ; accumulate

;; VARIABLES

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? x num)
  (and (number? x)
       (= x num)))

;; SUMS

#;(define (make-sum a1 a2)
  (list '+ a1 a2))

(define (sum? x)
  (and (pair? x)
       (eq? (car x) '+)))

(define (addend s)
  (cadr s))

(define (augend s)
  (accumulate make-sum 0 (cddr s))) ; new

(define (make-sum a1 a2)
  (cond
    ((=number? a1 0)
      a2)
    ((=number? a2 0)
      a1)
    ((and (number? a1)
	  (number? a2))
      (+ a1 a2))
    (else
      (list '+ a1 a2))))

;; PRODUCTS

#;(define (make-product m1 m2)
  (list '* m1 m2))

(define (product? x)
  (and (pair? x)
       (eq? (car x) '*)))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (accumulate make-product 1 (cddr p))) ; new

(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0)
	 (=number? m2 0))
      0)
    ((=number? m1 1)
      m2)
    ((=number? m2 1)
      m1)
    ((and (number? m1)
	  (number? m2))
      (* m1 m2))
    (else
      (list '* m1 m2))))

;; EXPONENTIATIONS

#;(define (make-exponentation b e)
  (list '** b e))

(define (exponentiation? x)
  (and (pair? x)
       (eq? (car x) '**)))

(define (base x)
  (cadr x))

(define (exponent x)
  (caddr x))

(define (make-exponentiation b e)
  (cond
    ((=number? e 0)
      1)
    ((=number? b 0)
      0)
    ((and (number? b)
	  (number? e))
      (exp '(b e)))
    (else
      (list '** b e))))

;; DERIVATION

(define (deriv exp var)
  (cond ((number? exp)
	  0)
        ((variable? exp)
          (if (same-variable? exp var)
	      1
	      0))
        ((sum? exp)
          (make-sum
	    (deriv (addend exp) var)
	    (deriv (augend exp) var)))
        ((product? exp)
          (make-sum
	    (make-product
	      (multiplier exp)
	      (deriv (multiplicand exp) var))
	    (make-product
	      (deriv (multiplier exp) var)
	      (multiplicand exp))))
	((exponentiation? exp)
	  (make-product
	    (make-product
	      (exponent exp)
	      (make-exponentiation
		(base exp)
		(make-sum
		  (exponent exp)
		  -1)))
	    (deriv (base exp) var)))
	(else
         (error "unknown expression type -- DERIV" exp))))

;; my only changes were to the augend and multiplicand selectors, which now
;; recursively fold sums and products into their arguments.

(display (deriv '(+ x (** x 3)) 'x))
; (* 3 (** x 2))

