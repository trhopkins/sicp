;;; Exercise 2.14, page 97

;; After considerable work, Alyssa P. Hacker delivers her finished system.
;; Several years later, after she has forgotten all about it, she gets a
;; frenzied call from an irate user, Lem E. Tweakit. It seems that Lem has
;; noticed that the formula for parallel resistors can be written in two
;; algebraically equivalent ways:

;; LaTeXery here...

;; He has written the following two programs, each of which computes the
;; parallel-resistors formula differently:

(load "interval.ss")

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; Lem complains that Alyssa's program gives different answers for the two ways
;; of computing. This is a serious complaint.

;; ...and onto the problem.

;; Demonstrate that Lem is right. Investigate the behavior of the system on a
;; variety of arithmetic expressions. Make some intervals A and B, and use them
;; in computing the expressions A/A and A/B. You will get the most insight by
;; using intervals whose width is a small percentage of the center value.
;; Examine the results of the computation in center-percent form (see exercise
;; 2.12).

(let ((one (make-interval 1 3)))
  (display (div-interval one one))) ; should return exactly one
(newline)
(let ((a (make-interval 1 3))
      (b (make-interval 2 4)))
  (if (eq? (par1 a b) (par2 a b))
      (display "it works!")
      (display "it doesn't work...")))

