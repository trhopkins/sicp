;; Exercise 1.4, page 21

;; Describe the behavior of the following function:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; the if statement parses (> b 0) and chooses the operation to perform

