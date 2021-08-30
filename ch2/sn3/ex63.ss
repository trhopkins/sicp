;;; Exercise 2.63, page 158

;; Each of the following two procedures converts a binary tree to a list.

#;(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

#;(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

;; a. Do the two procedures produce the same result for every tree? If not, how
;; do the results differ? What lists do the two procedures produce for the
;; trees in figure 2.16?

;; b. Do the two procedures have the same order of growth in the number of
;; steps required to convert a balanced tree with n elements to a list? If not,
;; which one grows more slowly? 

(define (entry tree)
  (car tree)) ; first

(define (left-branch tree)
  (cadr tree)) ; second

(define (right-branch tree)
  (caddr tree)) ; third

(define (make-tree entry left right)
  (list entry left right))

(define (element? x set) ; O(n)
  (cond
    ((null? set)
      #f)
    ((= x (entry set))
      #t)
    ((< x (entry set))
      (element? x (left-branch set)))
    (else ; x > (entry set)
      (element? x (right-branch set)))))

(define (adjoin x set) ; O(log(n))
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

(define (tree->list-1 tree) ; O(n*log(n))
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

