;;; Exercise 2.60, page 153

;; We specified that a set would be represented as a list with no duplicates.
;; Now suppose we allow duplicates. For instance, the set {1,2,3} could be
;; represented as the list (2 3 2 1 3 2 2). Design procedures element-of-set?,
;; adjoin-set, union-set, and intersection-set that operate on this
;; representation. How does the efficiency of each compare with the
;; corresponding procedure for the non-duplicate representation? Are there
;; applications for which you would use this representation in preference to
;; the non-duplicate one?

(load "../utils.ss")

(define (element? x set)
  (cond
    ((null? set)
      #f)
    ((equal? x (car set))
      #t)
    (else
      (element? x (cdr set)))))

(define (adjoin x set)
  (cons x set))

(define (intersection set1 set2)
  (cond
    ((or (null? set1) (null? set2))
      '())
    ((element? (car set1) set2)
      (cons (car set1)
            (intersection (cdr set1) set2)))
    (else
      (intersection (cdr set1) set2))))

(define (union set1 set2)
  (if (null? set1)
      set2
      (cons (car set1)
            (union (cdr set1) set2))))

(display (intersection '(a a a b c) '(a b d)))

