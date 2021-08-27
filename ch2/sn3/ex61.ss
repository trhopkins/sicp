;;; Exercise 2.61, page 155

;; representation of sets using ordered numbers

(define (element? x set) ; average O(0.5n) time
  (cond
    ((null? set)
      #f)
    ((= x (car set))
      #t)
    ((< x (car set))
      #f)
    (else
      (element? x (cdr set)))))

(define (intersection set1 set2) ; O(n) time
  (let ((x1 (car set1))
        (x2 (car set2)))
    (cond
      ((or (null? set1) (null? set2))
        '())
      ((< x1 x2)
        (intersection (cdr set1) set2))
      ((> x1 x2)
        (intersection set1 (cdr set2))))))

(define (adjoin x set)
  (cond
    ((null? set)
      (list x))
    ((> x (car set))
      (cons (car set)
            (adjoin x (cdr set))))
    ((< x (car set))
      (cons x set))
    (else ; =
      set)))

;(display (adjoin 10 '(1 3 7)))
      
