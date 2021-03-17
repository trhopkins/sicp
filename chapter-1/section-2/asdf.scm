(define (sqrt x) ; lexically scope sqrt
  (sqrt-iter 1.0)
  (define (sqrt-iter guess)
    (if (good-enough?)
            guess
            (sqrt-iter (improve) x))
    (define (improve)
      (average guess (/ x guess)))
      (define (average x)
        (/ (+ guess x) 2))
    (define (good-enough?)
      (= guess (/ x guess)))))

