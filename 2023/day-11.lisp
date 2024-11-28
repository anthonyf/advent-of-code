(uiop:define-package #:aoc/2023/day-11
  (:use #:cl)
  (:mix #:aoc/util
	#:iterate)
  )

(in-package #:aoc/2023/day-11)

(defparameter *sample* (string-lines "...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#....."))

(iter (for y from 0 below (length *sample*))
  (collect y result-type vector))

(defun galaxy-positions (input)
  (iter (for y from 0 below (length input))
    (for line = (svref input y))
    (for exp-y = 0)
    (if (iter (for char in-vector line)
	  (always (eql #\. char)))
	(incf exp-y)
	
	(appending (iter (for x from 0 below (length line))
		     (when (eql #\# char)
		       (collect (cons x (+ y exp-y)))))))))

#+nil
(galaxy-positions *sample*)
