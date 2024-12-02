(uiop:define-package #:aoc/2024/day-02
  (:use #:cl)
  (:import-from #:ppcre
		#:split)
  (:mix #:aoc/util))

(in-package #:aoc/2024/day-02)

(defun parse-lines (lines)
  (mapcar (lambda (line)
	    (mapcar #'parse-integer
		    (split " " line))) 
	  lines))

(defparameter *sample* (parse-lines (string-lines "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9")))

(defparameter *input* (parse-lines (input-lines 2024 2)))

(defun solve-1 (input)
  (loop for levels in input
	sum (if (or (loop for (a b) on levels by #'cdr
			  always (and b (> a b)
				      #+nil (let ((increase (- b a)))
					(and (> increase 1)
					     (<= increase 3)))))
		    (loop for (a b) on levels by #'cdr
			  always (and b (< a b)
				      #+nil(let ((decrease (- a b)))
					(and (> decrease 1)
					     (<= decrease 3))))))
		1
		0)))

#+nil
(solve-1 *sample*)
