;;; Exercise 2.38, page 121

;; The accumulate procedure is also known as fold-right, because it combines
;; the first element of the sequence with the result of combining all the
;; elements to the right. There is also a fold-left, which is similar to
;; fold-right, except that it combines elements working in the opposite
;; direction:

(load "../utils.ss") ; require accumulate/fold-right

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))

;; What are the values of:

(fold-right / 1 (list 1 2 3))
;; 3/2

(fold-left / 1 (list 1 2 3))
;; 1/6

(fold-right list nil (list 1 2 3))
;; (1 (2 (3 ())))

(fold-left list nil (list 1 2 3))
;; (((() 1) 2) 3)

;; Give a property that op should satisfy to guarantee that fold-right and
;; fold-left will produce the same values for any sequence. 

;; the property of associativity states that a function must give the same
;; result when applied in any order. For instance, a + (b + c) should return
;; the same result as (a + b) + c

;; the property of commutativity states that a function must give the same
;; result when applied to the same variables no matter how they are rearranged.
;; For instance, a + b should return the same result as b + a

;; sidenote: can fold-left be made simpler with the following?
(define (fold-left op init seq)
  (if (null? seq)
      init
      (fold-left op (op init (car seq)) (cdr seq))))

