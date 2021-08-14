;;; THE LAMBDA CALCULUS

;; HELPER FUNCTIONS

; Unicode character u03bb, the lambda symbol
(define-syntax λ
  (syntax-rules ()
    [(_ (arg* ...)
        body body* ...)
      (lambda (arg* ...)
        body body* ...)]))

; convert between numerical representations
(define (church->num c)
  ((c (λ (n) (+ n 1))) 0))

; wrap a function in a thunk
(define (thunk f) ; Chez Scheme hitches with these: fix later?
  (λ ()
     f))

; delay === thunk
(define delay thunk)

; unwrap a thunk by applying it
(define (force f)
  (f))

;; CHURCH NUMERALS

; do something zero times
(define zero
  (λ (f)
    (λ (x)
      x)))

(define once   (λ (f) (λ (x) (f x)))) ; do something one time
(define twice  (λ (f) (λ (x) (f (f x))))) ; do something two times
(define thrice (λ (f) (λ (x) (f (f (f x)))))) ; and so on

; n++
(define inc
  (λ (n)
    (λ (f)
      (λ (x)
        (f ((n f) x))))))

; successor === increment
(define succ inc)

; m + n
(define add
  (λ (m)
    (λ (n)
      (λ (f)
        (λ (x)
          ((m f) ((n f) x)))))))

; m * n
(define mul
  (λ (m)
    (λ (n)
      (λ (f)
        (m (n f))))))

; b ** e
(define pow
  (λ (b)
    (λ (e)
      (e b)))) ; magic

; basic numbers
(define one   (inc zero))  ; once
(define two   (inc one))   ; twice
(define three (inc two))   ; thrice
(define four  (inc three)) ; fourfold
(define five  (inc four))  ; fivefold, etc
(define six   (inc five))
(define seven (inc six))
(define eight (inc seven))
(define nine  (inc eight))
(define ten   (inc nine))

; clarification
(define add
  (λ (m)
    (λ (n)
      ((n inc) m))))

; clarification
(define mul
  (λ (m)
    (λ (n)
      ((n (add m)) zero))))

; clarification. Noticing a pattern?
(define pow
  (λ (m)
    (λ (n)
      ((n (mul m)) one))))

; n--
(define dec ; huge cf
  (λ (n)
    (λ (f)
      (λ (x)
        ((n (λ (g) (λ (h) (h (g f))))
            (λ (u) x)
            (λ (u) u)))))))

; predecessor === decrement
(define pred dec)

; m - n
(define sub ; I'm not even going to show the original
  (λ (m)
    (λ (n)
      ((n dec) m))))

;; BOOLEANS

; true === Kestrel
(define true
  (λ (x)
    (λ (y)
      x)))

; false === Kite
(define false
  (λ (x)
    (λ (y)
      y)))

; p && q
(define and
  (λ (p)
    (λ (q)
      ((p q) p))))

; p || q
(define or
  (λ (p)
    (λ (q)
      ((p p) q))))

; !p == Cardinal
(define not
  (λ (p)
    ((p false) true)))

; p == q
(define beq ; boolean equals
  (λ (p)
     (λ (q)
	((p q) (not q)))))

; ternary logic: predicate, consequent, alternative
(define if-then-else
  (λ (p)
    (λ (c)
      (λ (a)
        ((p c) a)))))

; true if zero, else false
(define is-zero
  (λ (n)
    ((n (λ (x) false)) true)))

; m == n
(define neq ; 'numerical' equals
  (λ (m)
     (λ (n)
	(is-zero ((sub m) n)))))

; m less than or equal to n
(define leq
  (λ (m)
    (λ (n)
      (is-zero ((sub m) n)))))

;; PAIRS

; construct (x, y)
(define pair
  (λ (x)
    (λ (y)
      (λ (f)
        ((f x) y)))))

; select x from (x, y)
(define fst
  (λ (p)
    (p true)))

; select y from (x, y)
(define snd
  (λ (p)
    (p false)))

; empty pair and list terminator
(define nil
  (λ (x)
    true))

; p == nil
(define is-null
  (λ (p)
    ((p false) true)))

; lisp terminology
(define cons pair)
(define car  fst)
(define cdr  snd)

; decrement helper function
(define phi
  (λ (x)
     ((pair (snd x)) (inc (snd x)))))

; transparent decrement
(define dec
  (λ (n)
     (fst ((n phi) ((pair zero) zero)))))

;; COMBINATORS

; Identity/Idiot
(define I ; Ix => x
  (λ (x)
     x))

; Kestrel
(define K ; Kxy => x
  (λ (x)
     (λ (y)
        x)))

; Kite
(define KI ; KIxy => y
  (λ (x)
     (λ (y)
        y)))

; Mockingbird
(define M ; Mx => xx
  (λ (x)
     (x x)))

; Cardinal
(define C ; Cxyz => xzy
  (λ (x)
     (λ (y)
        (λ (z)
           ((x z) y)))))

; Bluebird
(define B ; Bxyz => x(yz)
  (λ (x)
     (λ (y)
        (λ (z)
           (x (y z))))))

; Warbler
(define W ; Wxy => xyy
  (λ (x)
     (λ (y)
        ((x y) y))))

; Starling
(define S ; Sxyz => xz(yz)
  (λ (x)
     (λ (y)
        (λ (z)
           ((x z) (y z))))))

;; RECURSION

; Omega bird. Note: breaks Chez Scheme evaluation?
#;(define U ; U => MM
  (M M))

; Sage Bird?
(define Y ; Yf => f(Yf)
  (λ (f)
     ((λ (x)
         (f (x x)))
      (λ (x)
         (f (x x))))))

; delay intermediate values
(define lazy-Y
  (λ (f)
     ((λ (x)
         (f (λ () (x x))))
      (λ (x)
         (f (λ () (x x)))))))

; n!
(define fact
  (λ (n)
     (if (zero? n)
         1
         (* n (fact ((λ (n) (- n 1)) n)))))) ; note self-ref

; n! but in CPS
(define lazy-fact
  (λ (cont)
     (λ (n)
        (if (zero? n)
            1
            (* n ((cont) ((λ (n) (- n 1)) n))))))) ; self-ref removed!

(display ((lazy-Y lazy-fact) 5)) ; proof of work

