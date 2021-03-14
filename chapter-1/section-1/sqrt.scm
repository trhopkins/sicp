;;; Example 1.1.7
;; square-root by Newton's Method

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

;; consider defining as % difference from previous guess
(define (good-enough? guess x) ; try this but with sig figs?
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (square x) ; may be primitive function?
  (* x x))

(define (average x y)
  (/ (+ x y) 2))
