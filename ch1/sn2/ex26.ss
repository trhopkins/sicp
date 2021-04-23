;;; Exercise 1.26 page 55

;; Louis Reasoner is having great difficulty doing exercise 1.24. His
;; fast-prime? test seems to run more slowly than his prime? test. Louis
;; calls his friend Eva Lu Ator over to help. When they examine Louis's
;; code, they find that he has rewritten the expmod procedure to use an
;; explicit multiplication, rather than calling square:

(define (expmod base exp m)
  (cond ((=exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- 3xp 1) m))
                    m))))

;; Louis's multiplication procedure creates a tree-recursive process
;; that takes O(n^2) operations, and each operation takes O(log(n)) time
;; to complete, so they cancel out to create an O(n) time/space
;; procedure.
