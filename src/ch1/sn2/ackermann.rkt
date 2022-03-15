#lang sicp

(#%require rackunit)

;;; Ackermann's function
(define (A x y)
  (cond ((zero? y) 0)
        ((zero? x) (* 2 y))
        ((= y 1) 2)
        (else (A (dec x) ; decrement function?
                 (A x (dec y))))))

;; What are the values of the following expressions?

(check-equal? (A 1 10)
              1024)

(check-equal? (A 2 4)
              65536)

(check-equal? (A 3 3)
              65536)

;(A 1 10)
;(A (- 1 1) (A 1 (- 10 1)))
;(A 0 (A 1 9))
;(A 0 (A (- 1 1) (A 1 (- 9 1))))
;(A 0 (A 0 (A 1 8)))
;;; skipping intermediate expansions for brevity and clarity...
;(A 0 (A 0 (A 0 (A 1 7))))
;(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
;(A 0 (A 0 (A 0 (A 0 64))))
;(A 0 (A 0 (A 0 128)))
;(A 0 (A 0 256))
;(A 0 512)
;1024

;; consider memoization?
;(A 2 4)
;(A 1 (A 2 3))
;(A 1 (A 1 (A 2 2)))
;(A 1 (A 1 (A 1 (A 2 1))))
;(A 1 (A 1 (A 1 2)))
;(A 1 (A 1 (A 0 (A 1 1))))
;(A 1 (A 1 (A 0 2)))
;(A 1 (A 1 4))
;(A 1 (A 0 (A 1 3)))
;(A 1 (A 0 (A 0 (A 1 2))))
;(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
;(A 1 (A 0 (A 0 (A 0 2))))
;(A 1 (A 0 (A 0 4)))
;(A 1 (A 0 8))
;(A 1 16)
;(A 0 (A 1 15))
;(A 0 (A 0 (A 1 14)))
;(A 0 (A 0 (A 0 (A 1 13))))
;(A 0 (A 0 (A 0 (A 0 (A 1 12)))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10))))))) ; flashbacks to (A 1 10). Consider memoization?
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
;(A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
;(A 0 (A 0 (A 0 (A 0 4096))))
;(A 0 (A 0 (A 0 8192)))
;(A 0 (A 0 16384))
;(A 0 32768)
;65536

;(A 3 3)
;(A 2 (A 3 2))
;(A 2 (A 2 (A 3 1)))
;(A 2 (A 2 2))
;(A 2 (A 1 (A 2 1)))
;(A 2 (A 1 2))
;(A 2 (A 0 (A 1 1)))
;(A 2 (A 0 2))
;(A 2 4) ; deja vu. Just going to skip that whole mess
;65536

