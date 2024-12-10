(uiop:define-package #:aoc/2024/day-06
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros
	#:trivia))

(in-package #:aoc/2024/day-06)

(defparameter *sample* (vmap-from-string "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."))

(defparameter *input* (vmap-from-string (input-string 2024 6)))

(defun starting-position (input)
  (loop named outer
	for (x . y) in (vmap-positions input)
	when (eql #\^ (vmap-at input (cons x y)))
	  do (return-from outer (list nil (cons x y) :north))))

(defparameter *directions* '((:north . ( 0 . -1))
			     (:east  . ( 1 .  0))
			     (:south . ( 0 .  1))
			     (:west  . (-1 .  0))))

(defun next-position (pos direction)
  (destructuring-bind (x . y)
      pos
    (destructuring-bind (nx . ny)
	(cdr (assoc direction *directions*))
      (cons (+ nx x) (+ ny y)))))

(defun right-of (direction)
  (car (nth (mod (1+ (position direction *directions* :key #'car))
		 (length *directions*))
	    *directions*)))

(defun step-position (input pos direction)
  (let ((next-pos (next-position pos direction)))
    (if (vmap-in-bounds-p input next-pos)
	(if (char= #\# (vmap-at input next-pos))
	    (list nil pos (right-of direction))
	    (list nil next-pos direction))
	(list t pos direction))))

(defun solve-1 (input)
  (length
   (remove-duplicates (loop until solvedp
			    for (solvedp pos direction) = (starting-position input)
			      then (step-position input pos direction)
			    collect pos)
		      :test #'equal)))

#+nil
(solve-1 *sample*)
 ; => 41 (6 bits, #x29, #o51, #b101001)

#+nil
(solve-1 *input*)
 ; => 5030 (13 bits, #x13A6)
