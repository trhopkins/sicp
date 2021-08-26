;;; Exercise 2.59, page 153

;; Implement the union operation for the unordered-list representation of
;; sets. 

(load "../utils.ss") ; accumulate

(define (element? x set)
  (cond
    ((null? set)
      #f)
    ((equal? x (car set))
      #t)
    (else
      (element? x (cdr set)))))

(define (adjoin x set)
  (if (element? x set)
      set
      (cons x set)))

(define (intersection set1 set2)
  (cond
    ((or (null? set1) (null? set2))
      '())
    ((element? set1 (car set2))
      (cons (car set2)
            (intersection set1 (cdr set2))))
    (else
      (intersection set1 (cdr set2)))))

(define (union set1 set2)
  (accumulate adjoin set2 set1))

(display (union '(a b d e) '(a b c)))

