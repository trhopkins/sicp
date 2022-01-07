;;; Exercise 2.5, page 92

;; Show that we can represent pairs of nonnegative integers using only numbers
;; and arithmetic operations if we represent the pair a and b as the integer
;; that is the product 2^a * 3^b. Give the corresponding definitions of the
;; procedures cons, car, and cdr.

(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car p) ; p = pair
  (define (iter p a)
    (if (not (integer? p))
        (- a 1)
        (iter (/ p 2) (+ a 1))))
  (iter p 0))

(define (cdr p) ; p = pair
  (define (iter p b)
    (if (not (integer? p))
        (- b 1)
        (iter (/ p 3) (+ b 1))))
  (iter p 0))

(define asdf (cons 3 10))
(display (car asdf))

