;;; Exercise 1.42, page 77

;; Let f and g be two one-argument functions. The composition f after g is
;; defined to be the function x -> f(g(x)). Define a procedure compose that
;; implements composition. For example, if inc is a procedure that adds 1 to
;; its argument:

;; ((compose square inc) 6)

;; is 49.

(define (compose2 f g)
  (lambda (x)
    (f (g x))))

(define (square n)
  (* n n))

(define (inc n)
  (+ n 1))

(define (compose . fs)
  (define (comp-iter args)
    (cond ((null? args)
            (lambda (x) x))
          (else
            (compose2 (car args)
                      (comp-iter (cdr args))))))
  (comp-iter fs))

(display ((compose square inc) 6))
;; 49

