;;; Exercise 2.59

;; Implement the union-set operation for the unordered-list representation of
;; sets. 

(define (member? x set)
  (cond
    ((null? set)
      #f)
    ((equal? x (car set))
      #t)
    (else
      (member? x (cdr set)))))

(define element-of-set? member?)

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond
    ((or (null? set1) (null? set2))
      '())
    ((element-of-set? set1 (car set2))
      (cons (car set2)
            (intersection-set set1 (cdr set2))))
    (else
      (intersection-set set1 (cdr set2)))))

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (union-set (cdr set1)
                 (adjoin-set (car set1) set2))))

(display (union-set '(a b d e) '(a b c)))

