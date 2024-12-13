(uiop:define-package #:aoc/2024/day-12
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-12)

(defparameter *sample* (vmap-from-string "AAAA
BBCD
BBCC
EEEC"))

(defparameter *input* (vmap-from-string (input-string 2024 12)))

(defun parimeter (group)
  (loop for (x . y) in group
	sum (loop for (ox . oy) in '(( 0 . -1)
				     ( 1 .  0)
				     ( 0 .  1)
				     (-1 .  0))
		  unless (member (cons (+ x ox) (+ y oy))
				 group :test #'equal)
		    sum 1)))

(defun solve-1 (input)
  (loop for group in (vmap-find-groups input)
	sum (* (length group) (parimeter group))))

#+nil
(solve-1 *sample*)
 ; => 140 (8 bits, #x8C, #o214, #b10001100)

#+nil
(solve-1 *input*)
 ; => 1352976 (21 bits, #x14A510)
