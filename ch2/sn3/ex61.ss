;;; Exercise 2.61, page 155

;; representation of sets using ordered numbers

(define (element-list? x set) ; average O(0.5n) time
  (cond
    ((null? set)
      #f)
    ((= x (car set))
      #t)
    ((< x (car set))
      #f)
    (else
      (element-list? x (cdr set)))))

(define (adjoin-list x set)
  (cond
    ((null? set)
      (list x))
    ((> x (car set))
      (cons (car set)
            (adjoin-list x (cdr set))))
    ((< x (car set))
      (cons x set))
    (else ; =
      set)))

(define (intersection-list set1 set2) ; O(n) time
  (let ((x1 (car set1))
        (x2 (car set2)))
    (cond
      ((or (null? set1) (null? set2))
        '())
      ((< x1 x2)
        (intersection-list (cdr set1) set2))
      ((> x1 x2)
        (intersection-list set1 (cdr set2))))))

