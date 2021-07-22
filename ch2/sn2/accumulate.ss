;;; Accumulate procedure, page 116

;; AKA foldl in Haskell
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

