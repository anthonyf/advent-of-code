(uiop:define-package #:advent-of-code/2023/day-10
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate)
  )

(in-package #:advent-of-code/2023/day-10)

(defparameter *pipes* '((#\| (0 -1)  (0 1)) ;;is a vertical pipe connecting north and south.
			(#\- (1  0) (-1 0)) ;;is a horizontal pipe connecting east and west.
			(#\L (0 -1)  (1 0)) ;;is a 90-degree bend connecting north and east.
			(#\J (0 -1) (-1 0)) ;;is a 90-degree bend connecting north and west.
			(#\7 (0  1) (-1 0)) ;;is a 90-degree bend connecting south and west.
			(#\F (0  1)  (1 0)) ;;is a 90-degree bend connecting south and east.
			(#\. ) ;; is ground ; there is no pipe in this tile.
			(#\S) ;; is the starting position of the animal ; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
			))

(defparameter *sample* (string-lines ".....
.S-7.
.|.|.
.L-J.
....."))

(defun starting-position (input)
  (iter
    (for y from 0)
    (for line in input)
    (for x = (position #\S line))
    (finding (cons x y) such-that x)))

#+nil
(starting-position *sample*)


;;(defun step (input n ))

(defun solve-1 (input)
  )

