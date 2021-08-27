;;; Exercise 2.62, page 155

;; representation of sets using ordered numbers: union

(load "ex61.ss")

(define (union set1 set2) ; O(n) merge from merge-sort
  (cond
    ((null? set1)
      set2)
    ((null? set2)
      set1)
    (else
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond
          ((> x1 x2)
            (cons x2 (union set1 (cdr set2))))
          ((< x1 x2)
            (cons x1 (union (cdr set1) set2)))
          (else ; x1 == x2
            (cons x1 (union (cdr set1) (cdr set2)))))))))

(display (union '(2 4) '(1 3 7)))
      
