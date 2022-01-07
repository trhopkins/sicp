;;; Exercise 2.4, page 92

;; Here is an alternative procedural representation of pairs. For this
;; representation, verify that (car (cons x y)) yields x for any objects x and
;; y.

(define (cons x y) ; construct a pair
  (lambda (m) (m x y)))

(define (car z) ; take the first element a pair
  (z (lambda (p q) p)))

;; What is the correspoonding definition of cdr?

(define (cdr z) ; take the second element a pair
  (z (lambda (p q) q)))

(define (A)
  5)

(define (B)
  7)

(display ((car (cons A B))))

;; TODO: show lambda calc/Smullyan representations of these. Bluebird?

