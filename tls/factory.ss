;;; The Little Schemer functions

;; page xii
(define atom? ; if s is an atom, return #t
  (lambda (s)
    (and (not (pair? s))
         (not (null? s)))))

;; page 16
(define lat? ; if l is a list of atoms, return #t
  (lambda (l)
    (cond
      ((null? l)
        #t)
      ((atom? (car l))
        (lat? (cdr l)))
      (else
        #f))))

;; page 22
(define member? ; if a is a member of lat, return #t
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else
        (or (eq? a (car lat))
            (member? a (cdr lat)))))))

;; page 36
(define rember ; remove member from list
  (lambda (a lat)
    (cond
      ((null? lat)
        (quote ()))
      ((eq? a (car lat))
        (cdr lat))
      (else
        (cons (car lat)
              (rember a (cdr lat)))))))

;; page 44
(define firsts ; return a list of the first S-expression for each list in l
  (lambda (l)
    (cond
      ((null? l)
        (quote ()))
      (else
        (cons (car (car l))
              (firsts (cdr l)))))))

;; page 50
(define insertR ; insert new to the right of old
  (lambda (new old lat)
    (cond
      ((null? lat)
        (quote ()))
      ((eq? old (car lat))
        (cons old
              (cons new (cdr lat))))
      (else
        (cons (car lat)
              (insertR new old (cdr lat)))))))

;; page 51
(define insertL ; insert new to the left of old
  (lambda (new old lat)
    (cond
      ((null? lat)
        (quote ()))
      ((eq? old (car lat))
        (cons new lat))
      (else
        (cons (car lat)
              (insertR new old (cdr lat)))))))

;; page 51
(define subst ; substitute the first instance of old with new
  (lambda (new old lat)
    (cond
      ((null? lat)
        (quote ()))
      ((eq? old (car lat))
        (cons new (cdr lat)))
      (else
        (cons (car lat)
              (subst new old (cdr lat)))))))

;; page 52
(define subst2 ; replace the first instance of o1 or o2 with new
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat)
        (quote ()))
      ((or (eq? o1 (car lat))
           (eq? o2 (car lat)))
        (cons new (cdr lat)))
      (else
        (cons (car lat)
              (subst2 new o1 o2 (cdr lat)))))))

;; page 53
(define multi-rember ; delete all instances of a from lat
  (lambda (a lat)
    (cond
      ((null? lat)
        (quote ()))
      ((eq? a (car lat))
        (multi-rember a (cdr lat)))
      (else
        (cons (car lat)
              (rember a (cdr lat)))))))
