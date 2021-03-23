;;; The Little Schemer functions

;; page xii, 10
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

;; page 16
(define lat?
  (lambda (x)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))
