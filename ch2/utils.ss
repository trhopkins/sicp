;;; Chapter 2 utility functions

;; page 103
(define (append l1 l2)
  (if (null? l1)
      l2
      (cons (car l1)
            (append (cdr l1) l2))))

;; page 105
(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))

;; page 107
(define (for-each f l)
  (if (not (null? l))
      (begin
        (f (car l))
        (for-each f (car l)))))

;; page 113
(define (tree-map f t)
  (cond
    ((null? t)
      '())
    ((not (pair? t))
      (f t))
    (else
      (cons (tree-map f (car t))
            (tree-map f (cdr t))))))

;; page 115
(define (filter test? l)
  (cond
    ((null? l)
      '())
    ((test? (car l))
      (cons (car l)
            (filter test? (cdr l))))
    (else
      (filter test? (cdr l)))))

;; page 116
(define (accumulate f init l)
  (if (null? l)
      init
      (f (car l)
         (accumulate f init (cdr l)))))

;; page 116
(define (enumerate-interval lo hi)
  (if (> lo hi)
      '()
      (cons lo
            (enumerate-interval (+ lo 1) hi))))

;; page 116
(define (enumerate-tree t)
  (cond
    ((null? t)
      '())
    ((not (pair? t))
      (list t))
    (else
      (append (enumerate-tree (car t))
              (enumerate-tree (car t))))))

