(uiop:define-package #:aoc/2024/day-14
  (:use #:cl)
  (:import-from #:serapeum
		#:split-sequence)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-14)

(defparameter *sample* "p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3")

(defparameter *input* (input-string 2024 14))

(defun parse-input (input)
  (loop for line in (string-lines input)
	collect (ppcre:register-groups-bind (px py vx vy) ("p=([\\-0-9]+),([\\-0-9]+) v=([\\-0-9]+),([\\-0-9]+)" line)
		  (mapcar #'parse-integer (list px py vx vy)))))

#+nil
(parse-input *sample*)

(defun move-robot (px py vx vy w h)
  (let ((px (mod (+ px vx) w))
	(py (mod (+ py vy) h)))
    (list px py vx vy)))

#+nil
(move-robot 0 0 10 12 10 10)

(defun move-robots (s w h)
  (loop for (px py vx vy) in s
	collect (move-robot px py vx vy w h)))

(defun score (s w h)
  (loop for (px py vx vy) in s
	for xl = (and (>= px 0)
		      (< px (floor (/ w 2))))
	for yt = (and (>= py 0)
		      (< py (floor (/ h 2))))
	for xr = (and (>= px (ceiling (/ w 2)))
		      (< px w))
	for yb = (and (>= py (ceiling (/ h 2)))
		      (< px h))
	if (and xl yt)
	  sum 1 into a
	else if (and xr yt)
	       sum 1 into b
	else if (and xl yb)
	       sum 1 into c
	else if (and xr yb)
	       sum 1 into d
	finally (return (* a b c d))))

(defun solve-1 (input w h)
  (let ((s (loop repeat 100
		 for s = (move-robots (parse-input input) w h)
		   then (move-robots s w h)
		 finally (return s))))
    (score s w h)))

#+nil
(solve-1 *sample* 11 7)

#+nil
(solve-1 *input* 101 103)

(defun solve-2 (input w h)
  (let ((s (loop for i from 1 to (* 101 103)
		 for s = (move-robots (parse-input input) w h)
		   then (move-robots s w h)
		 collect (list i (score s w h)))))
    (caar (sort s #'< :key #'second))))

#+nil
(solve-2 *sample* 11 7)

#+nil
(solve-2 *input* 101 103)
