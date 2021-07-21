;; Append procedure, page ASDF

;; append attaches a list to the end of another one

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append (cdr list1) list2))))

