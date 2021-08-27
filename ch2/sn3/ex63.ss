;;; Exercise 2.63, page 158

;; naive (unbalanced) ordered tree set representation

(define (entry tree)
  (car tree)) ; first

(define (left-branch tree)
  (cadr tree)) ; second

(define (right-branch tree)
  (caddr tree)) ; third

(define (make-tree entry left right)
  (list entry left right))

(define (element? x set)
  (cond
    ((null? set)
      #f)
    ((= x (entry set))
      #t)
    ((< x (entry set))
      (element? x (left-branch set)))
    (else ; x > (entry set)
      (element? x (right-branch set)))))

(define (adjoin x set)
  (cond
    ((null? set)
      (make-tree x '() '()))
    ((= x (entry set))
      set)
    ((< x (entry set))
      (make-tree (entry set)
                 (adjoin x (left-branch set))
                 (right-branch set)))
    (else ; x > (entry set)
      (make-tree (entry set)
                 (left-branch set)
                 (adjoin x (right-branch set))))))

(define (tree->list-1 tree) ; O(n lg(n))
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree) ; O(n)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;(display (adjoin 6 (adjoin 3 (adjoin 11 (adjoin 5 (make-tree 8 '() '()))))))

(define first  (adjoin 11 (adjoin 5 (adjoin 1 (adjoin 9 (adjoin 3 (make-tree 7 '() '())))))))
(define second (adjoin 11 (adjoin 9 (adjoin 5 (adjoin 7 (adjoin 1 (make-tree 3 '() '())))))))
(define third  (adjoin 11 (adjoin 7 (adjoin 9 (adjoin 1 (adjoin 3 (make-tree 5 '() '())))))))

#|
(display (tree->list-1 first))
(newline)
(display (tree->list-2 first))
(newline)
(display (tree->list-1 second))
(newline)
(display (tree->list-2 second))
(newline)
(display (tree->list-1 third))
(newline)
(display (tree->list-2 third))
|#
(display first)

