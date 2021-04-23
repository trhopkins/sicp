;;; Exercise 1.15, page 44

;; The sine of an angle (specified in radians) can be computed by making
;; use of the approximation sin x = x if x is sufficiently small, and
;; the trigonometric identity:
;; sin(x) = 3sin(x/3) - 4sin^3(x/3)
;; to reduce the size of the input of sine. (For purposes of this
;; exercise an angle is considered "sufficiently small" if its magnitude
;; is less than 0.1 radians). These ideas are incorporated in the
;; following procedures:

(define (cube x)
  (* x x x))

(define (p x)
  (- (* 3 x) (* 4 (cube x))))

(define (sine x)
  (if (not (< 0.1 x))
      x
      (p (sine (/ x 3)))))

;; a. How many times is the procedure p applied when (sine 12.5) is
;; evaluated?  b. What is the order of growth in space and number of
;; steps (as a function of a) of the process generated when (sine a) is
;; evaluated?

;; (sine x) transforms x by dividing it by 3 each time. By dividing on
;; each recurrence, it has O(log(N)) efficiency. Therefore, (sine 12.5)
;; runs sine log_3(12.5) times

