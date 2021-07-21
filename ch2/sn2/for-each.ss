;;; For-each procedure, page ASDF

(define (for-each f l) ; function, list
  (if (not (null? l))
      (begin
        (f (car l))
        (for-each f (car l)))))

