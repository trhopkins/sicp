;;; Exercise 2.43, page 126

;; Louis Reasoner is having a terrible time doing exercise 2.42. His queens
;; procedure seems to work, but it runs extremely slowly. (Louis never does
;; manage to wait long enough for it to solve even the 6× 6 case.) When Louis
;; asks Eva Lu Ator for help, she points out that he has interchanged the order
;; of the nested mappings in the flatmap, writing it as

#;(flatmap
  (lambda (new-row)
    (map (lambda (rest-of-queens)
	   (adjoin-position new-row k rest-of-queens))
	 (queen-cols (- k 1))))
  (enumerate-interval 1 board-size))

;; Explain why this interchange makes the program run slowly. Estimate how long
;; it will take Louis's program to solve the eight-queens puzzle, assuming that
;; the program in exercise 2.42 solves the puzzle in time T.

(load "../utils.ss")

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  (cons (cons new-row
	      k)
	rest-of-queens))

(define (queen-in-k k positions)
  (cond ((null? positions)
	  '())
	((= (cdar positions) k)
	  (car positions))
	(else
	  (queen-in-k k (cdr positions)))))

(define (queens-not-k k positions)
  (cond ((null? positions)
	  '())
	((= (cdar positions) k)
	  (cdr positions))
	(else
	  (cons (car positions)
		(queens-not-k k (cdr positions))))))

(define (safe? k positions)
  (let ((queen-k (queen-in-k k positions))
	(o-queens (queens-not-k k positions)))
    (null? (filter
	     (lambda (o-q)
	       (or (= (car o-q) (car queen-k))
		   (= (- (car o-q) (cdr o-q))
		      (- (car queen-k) (cdr queen-k)))
		   (= (+ (car o-q) (cdr o-q))
		      (+ (car queen-k) (cdr queen-k)))))
	     o-queens))))

(define (queens board-size) ; procedure given in text
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board) ; '(())
        (filter
	  (lambda (positions)
	    (safe? k positions))
	  (flatmap ; code in question
	    (lambda (new-row)
	      (map (lambda (rest-of-queens)
		     (adjoin-position new-row k rest-of-queens))
		   (queen-cols (- k 1))))
	    (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

;; Louis's code runs through the entire search space before adding each queen,
;; going from O(N^2) to O(N^(N+2)) time complexity.

