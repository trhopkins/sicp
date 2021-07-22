;;; Filter procedure, page 115

(define (filter test? l)
  (cond
    ((null? l)
      '())
    ((test? (car l))
      (cons (car l) (filter test? (cdr l))))
    (else
      (filter test? (cdr l)))))

