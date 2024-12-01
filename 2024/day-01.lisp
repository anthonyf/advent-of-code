(uiop:define-package #:aoc/2024/day-01
  (:use #:cl)
  (:import-from #:serapeum
		#:frequencies)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-01)

(defun parse-lines (lines)
  (mapcar #'(lambda (line)
	      (mapcar #'parse-integer (ppcre:split "   " line)))
	  lines))

(defparameter *sample* (-> "3   4
4   3
2   5
1   3
3   9
3   3"
			 string-lines
			 parse-lines))

(defparameter *input* (-> (input-lines 2024 1)
			parse-lines))

(defun split-input (input)
  (loop for (a b) in input
 	collect a into as
	collect b into bs
	finally (return (values as bs))))

#+nil
(split-input *sample*)

(defun solve-1 (input)
  (multiple-value-bind (as bs)
      (split-input input)
    (let ((as (sort as #'<))
	  (bs (sort bs #'<)))
      (loop for a in as
	    for b in bs
	    sum (abs (- a b))))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)

(defun solve-2 (input)
  (multiple-value-bind (as bs)
      (split-input input)
    (let ((fbs (frequencies bs)))
      (loop for a in as
	    for freq = (gethash a fbs 0)
	    sum (* a freq)))))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)

