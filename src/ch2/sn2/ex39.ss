;;; Exercise 2.39, page 122

;; Complete the following definitions of reverse (exercise 2.18) in terms of
;; fold-right and fold-left from exercise 2.38:

(load "../utils.ss") ; fold-right and fold-left

#;(define (reverse sequence)
  (fold-right (lambda (x y) <??>) nil sequence))

#;(define (reverse sequence)
  (fold-left (lambda (x y) <??>) nil sequence))

(define (reverse seq)
  (fold-right (lambda (x y)
		(append y (cons x '())))
	      '()
	      seq))

#;(define (reverse seq)
  (fold-left (lambda (x y)
	       (cons y x))
	     '()
	     seq))

(display (reverse '(1 2 3 4 5)))

