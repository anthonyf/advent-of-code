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

(defun galaxy-positions (input)
  (let ((positions (iter (for line in input)
		     (for y from 0)
		     (appending (iter (for char in-vector line)
				  (for x from 0)
				  (when (eql #\# char)
				    (collect (cons x y))))))))
    (iter (for y from 0 below (length *sample))
      (for ys = (serapeum:keep y )))))

#+nil
(galaxy-positions *sample*)
