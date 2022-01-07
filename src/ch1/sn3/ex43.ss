;;; Exercise 1.43, page 77

;; If f is a numerical function and n is a positive integer, then we can form
;; the nth repeated application of f, which is defined to be the function whose
;; value at x is f(f(...(f(x))...)). For example, if f is the operation of
;; squaring a number, then the nth repeated application of f is the function
;; that raises its argument to the 2^nth power. Write a procedure that takes as
;; inputs a procedure that computes f and a positive integer n and returns the
;; procedure that ocmputes the nth repeated application of f. Your procedure
;; should be able to be used as follows:

;; ((repeated square 2) 5) ; 625

;; Hint: you may find it convenient to use compose2 from exercise 1.42.

(define (compose2 f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n) ; scheme wiki includes O(log n) version?
  (if (= n 1)
      f
      (compose2 f (repeated f (- n 1)))))

(define (square n)
  (* n n))

(display ((repeated square 2) 5))
;; 625

