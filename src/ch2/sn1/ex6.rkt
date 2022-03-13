#lang sicp

(#%require rackunit)

;;; Exercise 2.6, page 93

;; Below is a representation of Church numerals...

(define zero
  (lambda (f)
    (lambda (x)
      x)))

(define (inc n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

;; Define one and two directly (not in terms of zero and inc).
;; Give a direct definition of the addition procedure + (not in terms of
;; repeated application of inc).

;; (inc (zero))
(define one
  (lambda (f)
    (lambda (x)
      (f x))))

;; (inc (inc (zero)))
(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))

;; a `add` b
(define add
  (lambda (a b)
    (lambda (f)
      (lambda (x)
        ((a f) ((b f) x))))))

