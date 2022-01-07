#lang sicp

(#%require rackunit)

;;; Exercise 1.1, page 20

;; What do these expressions equate to?

(check-= 10 10 0)

(check-= (+ 5 3 4) 12 0)

(check-= (- 9 1) 8 0)

(check-= (/ 6 2) 3 0)

(check-= (+ (* 2 4) (- 4 6)) 6 0)

(define a 3) ; nothing?

(define b (+ a 1)) ; nothing?

(check-= (+ a b (* a b)) 19 0)

(check-false (= a b))

(check-= (if (and (> b a) (< b (* a b)))
    b
    a) 4 0)

(check-= (cond [(= a 4) 6]
               [(= b 4) (+ 6 7 a)]
               [else 25])
         16 0)

(check-= (+ 2 (if (> b a) b a)) 6 0)

(check-= (* (cond [(> a b) a]
                  [(< a b) b]
                  [else -1])
            (+ a 1))
         16 0)
