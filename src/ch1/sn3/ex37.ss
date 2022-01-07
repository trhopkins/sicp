;;; Exercise 1.37, page 71

;; An infinite continued fraction is an expression of the form... (TikZ here).

;; As an example, one can show that the infinite continued fraction expansion
;; with the N_i and the D_i all equal to 1 produces 1/phi, where phi is the
;; golden ratio (described in section 1.2.2). One way to approximate an
;; infinite continued fraction is to truncate it after a given number of terms.
;; Such a truncation--a so-called k-term finite continued fraction--has the
;; form... (More TikZ).

;; Suppose that n and d are procedures of one argument (the term index i) that
;; return the N_i and D_i of the terms of the continued fraction. Define a
;; procedure cont-frac such that evaluating (cont-frac n d k) computes the
;; value of the k-term finite continued fraction. Check your procedure by
;; approximating 1/phi using:

#;(cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k)

;; for successive values of k. How large must you make k in order to gen an
;; approximation that is accurate to four decimal places?

;; If your cont-frac procedure generates a recursive process, write one that
;; generates an iterative process. If your cont-frac procedure generates an
;; iterative process, write one that generates a recursive one.

(define (cont-frac n d k)
  (define (frac-rec i)
    (/ (n i)
       (+ (d i)
          (if (> i k)
              0
              (frac-rec (+ i 1))))))
  (frac-rec 1))

#;(define (cont-frac n d k) ; debug
  (define (frac-iter i acc)
    (if (= i 0)
        acc ; (/ (n i) (+ (d i) acc))?
        (frac-iter (+ i 1)
                   (/ (n i)
                      (+ (d i)
                         acc)))))
  (frac-iter k 0.0))

(define (n i)
  1.0)

(define (d i)
  1.0)

(display (cont-frac n d 20))
