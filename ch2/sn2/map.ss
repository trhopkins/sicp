;;; Map procedure, page ASDF

;; map applies a function to every element in a list and returns a list with
;; everything applied

(define (map f l) ; function, list
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

