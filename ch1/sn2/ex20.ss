;;; Exercise 1.20, page 49

;; Using the substitution model, (assuming normal order), illustrate the
;; process generated in evaluating (gcd 206 40) and indicate the
;; remainder operations that are actually performed. How many remainder
;; operations are actually performed in the normal-order evalutation of
;; (gcd 206 40)? In the applicative-order evaluation?

(define (gcd a b)
 (if (= b 0)
     a
     (gcd b (remainder a b))))

;; UNSOLVED

