;;; The Little Schemer functions

;; page xii
(define atom? ; if s is an atom, return #t
  (lambda (s) ; S-expression
    (and (not (pair? s)) (not (null? s)))))

;; page 16
(define lat? ; if l is a list of atoms, return #t
  (lambda (l) ; list
    (cond ; TLS-style blocks, cond and lambda on own lines
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

;; page 22
(define member? ; if a is a member of lat, return #t
  (lambda (a lat) ; atom, list of atoms. Could be S-expression and list
    (cond ; consider if here?
      ((null? lat) #f)
      (else (or (eq? a (car lat))
                (member? a (cdr lat)))))))

;; page 36
(define rember ; remove member from list
  (lambda (a lat) ; atom, list of atoms
    (cond
      ((null? lat) (quote ())) ; consider shorthand?
      ((eq? a (car lat)) (cdr lat))
      (else (cons (car lat)
                  (rember a (cdr lat)))))))

;; page 41
(define my-rember
  (lambda (a lat) ; atom, list of atoms. S-expression, list?
    (cond
      ((null? lat)
        ('())) ; shorthand quote
      ((eq? a (car lat))
        (cdr lat))
      (else
        (cons (car lat)
              (my-rember a (cdr lat)))))))
