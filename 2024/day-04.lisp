(uiop:define-package #:aoc/2024/day-04
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-04)

(defparameter *sample* (-> "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX"
			 string-lines
			 (coerce 'vector)))

(defparameter *input* (-> (input-lines 2024 4) (coerce 'vector)))

(defun offsets ()
  (loop for (ix iy) in '((-1 -1)(0 -1)(1 -1)
			 (-1  0)      (1  0)
			 (-1  1)(0  1)(1  1))
	collect (loop for l from 0 below 4
			    collect (cons (* ix l)(* iy l)))))

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

(defun solve-2 (input)
  (let ((height (length input))
	(width (length (aref input 0))))
    (loop for y from 0 below height
	  sum (loop for x from 0 below width
		    when (loop for (c . (ox . oy)) in '((#\M . (-1 . -1))
							(#\M . (-1 .  1))
							(#\A . ( 0 .  0))
							(#\S . ( 1 . -1))
							(#\S . ( 1 .  1)))
			       for nx = (+ x ox)
			       for ny = (+ y oy)
			       always (and (>= nx 0)
					   (< nx width)
					   (>= ny 0)
					   (< ny height)
					   (let ((pc (aref (aref input ny) nx))
						 (nnx (+ x (* -1 ox)))
						 (nny (+ y (* -1 oy))))
					     (or (and (char= c #\A)
						      (char= pc #\A))
						 (and (>= nnx 0)
						      (< nnx width)
						      (>= nny 0)
						      (< nny height)
						      (cond ((char= pc #\M)
							     (char= #\S (aref (aref input nny) nnx)))
							    ((char= pc #\S)
							     (char= #\M (aref (aref input nny) nnx)))))))))
		      sum 1))))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
