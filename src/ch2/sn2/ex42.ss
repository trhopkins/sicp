;;; Exercise 2.42, page 124

;; Figure 2.8:  A solution to the eight-queens puzzle (largely TeXery).

;; The ``eight-queens puzzle'' asks how to place eight queens on a chessboard
;; so that no queen is in check from any other (i.e., no two queens are in the
;; same row, column, or diagonal). One possible solution is shown in figure
;; 2.8. One way to solve the puzzle is to work across the board, placing a
;; queen in each column. Once we have placed k - 1 queens, we must place the
;; kth queen in a position where it does not check any of the queens already on
;; the board. We can formulate this approach recursively: Assume that we have
;; already generated the sequence of all possible ways to place k - 1 queens in
;; the first k - 1 columns of the board. For each of these ways, generate an
;; extended set of positions by placing a queen in each row of the kth column.
;; Now filter these, keeping only the positions for which the queen in the kth
;; column is safe with respect to the other queens. This produces the sequence
;; of all ways to place k queens in the first k columns. By continuing this
;; process, we will produce not only one solution, but all solutions to the
;; puzzle.

;; We implement this solution as a procedure queens, which returns a sequence
;; of all solutions to the problem of placing n queens on an nxn chessboard.
;; Queens has an internal procedure queen-cols that returns the sequence of all
;; ways to place queens in the first k columns of the board.

;; (moved procedure for convenience)

;; In this procedure rest-of-queens is a way to place k - 1 queens in the first
;; k - 1 columns, and new-row is a proposed row in which to place the queen for
;; the kth column. Complete the program by implementing the representation for
;; sets of board positions, including the procedure adjoin-position, which
;; adjoins a new row-column position to a set of positions, and empty-board,
;; which represents an empty set of positions. You must also write the
;; procedure safe?, which determines for a set of positions, whether the queen
;; in the kth column is safe with respect to the others. (Note that we need
;; only check whether the new queen is safe -- the other queens are already
;; guaranteed safe with respect to each other.)

(load "../utils.ss")

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
    (if (zero? k)
      '(())
        (filter
	  (lambda (positions)
	    (safe? k positions))
	  (flatmap
	    (lambda (rest-of-queens)
	      (map (lambda (new-row)
		     (adjoin-position new-row k rest-of-queens))
		   (enumerate-interval 1 board-size)))
	    (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (firsts list-of-pairs)
  (if (null? list-of-pairs)
      '()
      (cons (caar list-of-pairs)
	    (firsts (cdr list-of-pairs)))))

(define (format-results positions)
  (if (null? positions)
      '()
      (cons (firsts (car positions))
	    (format-results (cdr positions)))))

(define (display-formatted-results formatted-results)
  (if (not (null? formatted-results))
      (begin
	(display (car formatted-results))
	(newline)
	(display-formatted-results (cdr formatted-results)))))

#;(display (queens 8)) ; huge output
(define results (format-results (queens 4)))
(display-formatted-results results)
(newline)
(display (length (queens 4)))
(display " total answers")

;; sample answer from Figure 2.8: '(6 2 7 1 4 8 5 3)

