;;; Exercise 2.16, page 97

;; following from exercise 2.15...

;; Explain, in general, why equivalent algebraic expressions may lead to
;; different answers. Can you devise an interval-arithmetic package that does
;; not have this shortcoming, or is this task impossible? (Warning: This
;; problem is very difficult.)

;; the fundamental issue lies in the meaning of 'identity' among interval
;; values. The intervals [1, 2] and [1, 2] may have the same bounds, but
;; without knowing that they share the same identity, they could still differ
;; internally.

;; the values could carry their original reference with them, and keep track of
;; a list of changes made, and if those changes are ever undone precisely as
;; they were first applied (the 'identity' of the changes should also match
;; their inverses), their identity history would be preserved.

;; additionally, having things like the associative and distributive laws apply
;; to our system would mess with it even further. I'm going to follow my gut
;; and say that we cannot truly guarantee anything about these systems, and to
;; say otherwise might be too arrogant at my current level of understanding.

