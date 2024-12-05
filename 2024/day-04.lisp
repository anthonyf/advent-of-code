(uiop:define-package #:aoc/2024/day-04
  (:use #:cl)
  (:mix #:aoc/util
	#:cl-ppcre
	#:arrow-macros
	#:iterate))

(in-package #:aoc/2024/day-04)

(defparameter *sample* (coerce (string-lines "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX")
			       'vector))

(defparameter *input* (-> (input-lines 2024 4) (coerce 'vector)))

(defun offsets ()
  (loop for (ix iy) in '((-1 -1)(0 -1)(1 -1)
			 (-1  0)      (1  0)
			 (-1  1)(0  1)(1  1))
	collect (loop for l from 0 below 4
			    collect (cons (* ix l)(* iy l)))))

#+nil
(offsets)

(defun xmas-at-p (input x y)
  (let ((height (length input))
	(width (length (aref input 0))))
    (loop for os in (offsets)
	  when (loop for (ox . oy) in os
		     for nx = (+ x ox)
		     for ny = (+ y oy)
		     for c across "XMAS"
		     always (and (>= nx 0)
				 (< nx width)
				 (>= ny 0)
				 (< ny height)
				 (char= c (aref (aref input ny) nx))))
	    sum 1)))

#+nil
(xmas-at-p *sample* 0 0)

(defun solve-1 (input)
  (let ((height (length input))
	(width (length (aref input 0))))
    (loop for y from 0 below height
	 sum (loop for x from 0 below width
		   sum (xmas-at-p input x y)))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)
