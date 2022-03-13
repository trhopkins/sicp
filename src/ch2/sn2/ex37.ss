#lang sicp

(#%require rackunit)

;;; Exercise 2.37, page 120

;; Suppose we represent vectors v = (v_i) as sequences of numbers, and matrices
;; m = (m_ij) as sequences of vectors (the rows of the matrix). For example,
;; the matrix...

;; ...TeXery...

;; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)). With this
;; representation, we can use sequence operations to concisely express the
;; basic matrix and vector operations. These operations (which are described in
;; any book on matrix algebra) are the following:

;; ...TeXery...

;; We can define the dot product as

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;; Fill in the missing expressions in the following procedures for computing
;; the other matrix operations. (The procedure accumulate-n is defined in
;; exercise 2.36.)

(load "ex36.ss") ; require accumulate-n

(define (matrix-*-vector m v)
  (map (lambda (m-row)
         (dot-product m-row v))
       m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (m-row)
           (map (lambda (n-col)
                  (dot-product m-row n-col))
                cols))
         m)))

