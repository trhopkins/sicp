;;; Exercise 1.38, page 71

;; In 1737, the Swiss mathematician Leonhard Euler published a memoir De
;; Fractionibus Continuis, which included a continued fraction expansion for
;; e-2, where e is the base of the natural logarithms. In this fraction, the
;; N_i are all 1, and the D_i are successively:

;; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8...
;; 1  2  3  4  5  6  7  8  9  10 11

;; Write a program that uses your cont-frac procedure from exercise 1.37 to
;; approximate e, based on Euler's expansion.


(define (cont-frac n d k)
  (define (frac-rec i)
    (/ (n i)
       (+ (d i)
          (if (> i k)
              0
              (frac-rec (+ i 1))))))
  (frac-rec 1))

(define (n i)
  1.0)

(define (d i)
  (if (= (remainder i 3) 2)
      (/ (+ i 1) 1.5)
      1))

(display (cont-frac n d 20))
