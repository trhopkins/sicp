;;; For-each procedure, page 107

(define (for-each f l) ; function, list
  (if (not (null? l))
      (begin
        (f (car l))
        (for-each f (car l)))))

