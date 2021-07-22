;;; Map procedure, page 105

(define (map f l) ; function, list
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

