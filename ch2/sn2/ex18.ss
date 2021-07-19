;;; Exercise 2.18, page 107

;; Define a procedure reverse that takes a list as argument and returns a list
;; of the same elements in reverse order:

(define (last l)
  (if (null? (cdr l))
      (car l)
      (last (cdr l))))

(define (init l) ; all but last
  (if (null? (cdr l))
      '()
      (cons (car l)
            (init (cdr l)))))

(define (reverse l) ; rewrite as iterative process?
  (if (null? l)
      '()
      (cons (last l)
            (reverse (init l)))))

(display (reverse '(1 4 9 16 25)))
; (25 16 9 4 1)

