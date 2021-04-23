;;; Exercise 1.25 page 55

;; Alyssa P. Hacker complains that we went to a lot of extra work in
;; writing expmod. After all, she says, since we already know how to
;; compute exponentials, we could have simply written

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

;; Is she correct? Would this procedure serve as well for our fast prime
;; tester? Explain.

;; Alyssa's expmod would not serve as an expmod replacement, since it
;; deals with enormous intermediate numbers which are computationally
;; expensive. The original version keeps the resulting numbers to square
;; below the number you're testing for primality. If the large numbers
;; didn't make each multiplication operation take longer, since it takes
;; the same number of steps, it wouldn't matter.
