;;; Exercise 2.25, page 110

;; Give combinations of cars and cdrs that will pick 7 from each of the
;; following lists:

; (1 3 (5 7) 9)

; ((7))

; (1 (2 (3 (4 (5 (6 7))))))

(display (car (cdr (car (cdr (cdr '(1 3 (5 7) 9)))))))
(newline)
(display (car (car '((7)))))
(newline)
; (display (cadr (cadr (cadr (cadr (cadr (cadr '(1 (2 (3 (4 (5 (6 7)))))))))))))
(display (car
           (cdr
             (car
               (cdr
                 (car
                   (cdr
                     (car
                       (cdr
                         (car
                           (cdr
                             (car
                               (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))) ; whew
