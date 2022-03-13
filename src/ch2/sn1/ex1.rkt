#lang sicp

(#%require rackunit)

;;; Exercise 2.1, page 87

;; Define a better version of make-rat that handles both positive and negative
;; arguments. Make-rat should normalize the sign so that if the rational number
;; is positive, both the numerator and denominator are positive, and if the
;; rational number is negative, only the numerator is negative.

(define (gcd a b) ; page 49
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d) ; page 86
  (cons n d))

(define (make-rat n d) ; page 87
  (let ((g (gcd n d)))
    (cons (/ n g)
          (/ d g))))

(define (make-rat n d) ; first try
  (let ((g (gcd n d)))
    (cond ((and (negative? n)
                (negative? d))
            (cons (/ (abs n) g)
                  (/ (abs d) g)))
          ((negative? d)
            (cons (/ (- 0 n) g)
                  (/ (abs d) g)))
          (else
            (cons (/ n g)
                  (/ d g))))))

(define (make-rat n d) ; second try
  (let ((g (gcd n d)))
    (define (maybe-flip x)
      (if (negative? d)
          (- 0 x)
          (+ 0 x)))
    (cons (/ (maybe-flip n) g)
          (/ (maybe-flip d) g))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(display (print-rat (make-rat 2 -6)))

