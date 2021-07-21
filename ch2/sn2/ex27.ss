;;; Exercise 2.27, page 110

;; Modify your reverse procedure of exercise 2.18 to produce a deep-reverse
;; procedure that takes a list as argument and returns as its value the list
;; with its elements reversed and with all sublists deep-reversed as well. For
;; example,

(define x (list (list 1 2) (list 3 4)))

; x
; ((1 2) (3 4))

; (reverse x)
; ((3 4) (1 2))

; (deep-reverse x)
; ((4 3) (2 1))

(define (reverse l)
  (define (iter l result)
    (if (null? l)
        result
        (iter (cdr l) (cons (car l) result))))
  (iter l '()))

(define (deep-reverse l) ; TLS: reverse*
  (define (iter l result)
    (cond
      ((null? l)
        result)
      ((symbol? (car l))
        (iter (cdr l) (cons (car l) result)))
      (else
        (iter (cdr l) (cons (reverse (car l)) result)))))
  (iter l '()))

(display (deep-reverse '((1 2) (3 4))))
; ((4 3) (2 1))

