(uiop:define-package #:aoc/2024/day-10
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-10)

(defparameter *sample* (vmap-from-string "89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732"))

(defparameter *input* (vmap-from-string (input-string 2024 10)))

(defun trail-count (input pos)
  (let ((n (vmap-digit-at input pos)))
    (if (= n 9)
	(list pos)
	(let ((neighbors (vmap-neighbors-4 input pos)))
	  (loop for neighbor in neighbors
		for m = (vmap-digit-at input neighbor)
		when (= (1+ n) m)
		  append (trail-count input neighbor))))))

(defun solve-1 (input)
  (loop for pos in (vmap-positions input)
	for n = (vmap-digit-at input pos)
	when (= n 0)
	  sum (length (remove-duplicates (trail-count input pos) :test 'equal))))

#+nil
(solve-1 *sample*)
 ; => 36 (6 bits, #x24, #o44, #b100100)

#+nil
(solve-1 *input*)
 ; => 646 (10 bits, #x286)

(defun solve-2 (input)
  (loop for pos in (vmap-positions input)
	for n = (vmap-digit-at input pos)
	when (= n 0)
	  sum (length (trail-count input pos))))

#+nil
(solve-2 *sample*)
 ; => 81 (7 bits, #x51, #o121, #b1010001)

#+nil
(solve-2 *input*)
 ; => 1494 (11 bits, #x5D6)
