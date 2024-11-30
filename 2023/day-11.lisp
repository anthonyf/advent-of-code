(uiop:define-package #:aoc/2023/day-11
  (:use #:cl)
  (:mix #:aoc/util)
  )

(in-package #:aoc/2023/day-11)

(defparameter *sample* (coerce  (string-lines "...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....")
				'vector))

(defparameter *input* (coerce (input-lines 2023 11) 'vector))

(defun solve-1 (input)
  (let* ((y-expantions (coerce (loop for y from 0 below (length input)
				     with exp = 0
				     if (loop for x from 0 below (length (aref input 0))
					      always (eql #\. (aref (aref input y) x)))
				       collect (incf exp)
				     else
				       collect exp)
			       'vector))
	 (x-expansions (coerce (loop for x from 0 below (length (aref input 0))
				     with exp = 0
				     if (loop for y from 0 below (length input)
					      always (eql #\. (aref (aref input y) x)))
				       collect (incf exp)
				     else
				       collect exp)
			       'vector))
	 (galaxy-positions (loop for y from 0 below (length input)
				 appending (loop for x from 0 below (length (aref input 0))
						 when (eql #\# (aref (aref input y) x))
						   collect (cons (+ x (aref x-expansions x))
								 (+ y (aref y-expantions y)))))))
    (loop for ((x1 . y1) . rest) on galaxy-positions
	  sum (loop for (x2 . y2) in rest
		    sum (+ (abs (- x1 x2)) (abs (- y1 y2)))))
    ))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)
