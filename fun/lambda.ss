;;; The Lambda Calculus

;; helper functions

(define-syntax λ ; Unicode character u03bb, the lambda symbol
  (syntax-rules ()
    [(_ (arg* ...)
	body body* ...)
      (lambda (arg* ...)
        body body* ...)]))

(define (church->num c)
  ((c (λ (n) (+ n 1))) 0))

;; Church numerals

(define zero ; do something zero times
  (λ (f)
    (λ (x)
      x)))

(define once   (λ (f) (λ (x) (f x)))) ; do something one time
(define twice  (λ (f) (λ (x) (f (f x))))) ; do something two times
(define thrice (λ (f) (λ (x) (f (f (f x)))))) ; and so on

(define inc
  (λ (n)
    (λ (f)
      (λ (x)
	(f ((n f) x))))))

(define succ inc) ; successor, increment

(define add
  (λ (m)
    (λ (n)
      (λ (f)
        (λ (x)
	  ((m f) ((n f) x)))))))

(define mul
  (λ (m)
    (λ (n)
      (λ (f)
        (m (n f))))))

(define pow
  (λ (b)
    (λ (e)
      (e b)))) ; magical simplification

(define one   (inc zero))
(define two   (inc one))
(define three (inc two))
(define four  (inc three))
(define five  (inc four))
(define six   (inc five))
(define seven (inc six))
(define eight (inc seven))
(define nine  (inc eight))
(define ten   (inc nine))

(define add
  (λ (m)
    (λ (n)
      ((n inc) m))))

(define mul
  (λ (m)
    (λ (n)
      ((n (add m)) zero))))

(define pow
  (λ (m)
    (λ (n)
      ((n (mul m)) one))))

(define dec ; huge cf involving pairs
  (λ (n)
    (λ (f)
      (λ (x)
	((n (λ (g) (λ (h) (h (g f))))
	    (λ (u) x)
	    (λ (u) u)))))))

(define pred dec) ; predecessor, decrement

(define sub
  (λ (m)
    (λ (n)
      ((n dec) m))))

;; booleans

(define true ; compare with Kestrel K
  (λ (x)
    (λ (y)
      x)))

(define false ; compare with zero
  (λ (x)
    (λ (y)
      y)))

(define and
  (λ (p)
    (λ (q)
      ((p q) p))))

(define or
  (λ (p)
    (λ (q)
      ((p p) q))))

(define not
  (λ (p)
    ((p false) true)))

(define ifthenelse
  (λ (p)
    (λ (a)
      (λ (c)
	((p a) c)))))

(define iszero
  (λ (n)
    ((n (λ (x) false)) true)))

(define leq
  (λ (m)
    (λ (n)
      (iszero ((sub m) n)))))

;; pairs

(define pair
  (λ (x)
    (λ (y)
      (λ (f)
	((f x) y)))))

(define fst
  (λ (p)
    (p true)))

(define snd
  (λ (p)
    (p false)))

(define nil ; empty pair. Also list terminator
  (λ (x)
    true))

(define isnull
  (λ (p)
    ((p false) true)))

(define cons pair) ; lisp terminology
(define car  fst)
(define cdr  snd)

;; common combinators

(define I ; Identity/Idiot
  (λ (x)
     x))

(define K ; Kestrel
  (λ (x)
     (λ (y)
	x)))

(define S ; Starling
  (λ (x)
     (λ (y)
	(λ (z)
	   ((x z) (y z))))))

(define B ; Bluebird
  (λ (x)
     (λ (y)
	(λ (z)
	   (x (y z))))))

(define C ; Cardinal
  (λ (x)
     (λ (y)
	(λ (z)
	   ((x z) y)))))

(define W ; Warbler
  (λ (x)
     (λ (y)
	((x y) y))))

(define M ; Mockingbird
  (λ (x)
     (x x)))

;; recursion

#;(define U ; infinite! Breaks Chez Scheme when evaluated?
  (M M))

(define Y ; (Y f) => (f (Y f)). Beware eager evaluation
  (λ (f)
     ((λ (x)
	 (f (x x)))
      (λ (x)
	 (f (x x))))))

(define lazy-Y ; thunk intermediate values
  (λ (f)
     ((λ (x)
	 (f (λ () (x x))))
      (λ (x)
	 (f (λ () (x x)))))))

(define fact
  (λ (n)
     (if (zero? n)
         1
	 (* n (fact ((λ (n) (- n 1)) n))))))

(define lazy-fact ; NOTE: continuation application forces thunk
  (λ (cont)
     (λ (n)
	(if (zero? n)
	    1
	    (* n ((cont) ((λ (n) (- n 1)) n)))))))

(display ((lazy-Y lazy-fact) 5))

