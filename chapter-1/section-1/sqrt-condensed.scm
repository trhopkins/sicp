;;; Example 1.1.7
;; square-root by Newton's Method
;; this code has been condensed to prove a point to my friend Josh

(define (sqrt x) (sqrt-iter 1.0 x)) (define (sqrt-iter guess x) (if (good-enough? guess x) guess (sqrt-iter (improve guess x) x))) (define (good-enough? guess x) (< (abs (- (square guess) x)) 0.001)) (define (improve guess x) (average guess (/ x guess))) (define (square x) (* x x)) (define (average x y) (/ (+ x y) 2))