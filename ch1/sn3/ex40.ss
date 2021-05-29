;;; Exercise 1.40, page 77

;; Define a procedure cubic that can be used together with the newtons-method
;; procedure in expressions of the form:

;; (newtons-method (cubic a b c) 1)

;; to approximate zeroes of the cubic x^3 + ax^2 + bx + c

(define dx 0.00001)
(define tolerance dx)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (deriv f)
    (lambda (x)
      (/ (- (f (+ x dx))
            (f x))
         dx)))

(define (newton-transform f)
  (lambda (x)
    (- x (/ (f x)
            ((deriv f) x)))))

(define (newtons-method f guess)
  (fixed-point (newton-transform f) guess))

(define (cubic a b c)
  (lambda (x)
    (+ (expt x 3)
       (* a (expt x 2))
       (* b x)
       c)))

(display (newtons-method (cubic a b c) 1))

