(uiop:define-package #:aoc/2024/day-03
  (:use #:cl)
  (:mix #:aoc/util
	#:cl-ppcre
	#:arrow-macros))

(in-package #:aoc/2024/day-03)

(defparameter *sample* (string-lines "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"))
(defparameter *sample-2* (string-lines "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"))

(defparameter *input* (input-lines 2024 3))


(defun solve-1 (input)
  (loop for line in input
	sum (->> line
	      (ppcre:all-matches-as-strings "mul\\(\\d+,\\d+\\)")
	      (lambda (muls)
		(loop for mul in muls
		      sum (register-groups-bind (a b)
			      ("mul\\((\\d+),(\\d+)\\)" mul)
			    (* (parse-integer a) (parse-integer b))))))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)


(->> *input*
  first
  (ppcre:all-matches-as-strings "(mul\\([0-9]{1,3},[0-9]{1,3}\\))|(do\\(\\))|(don't\\(\\))"))

(defun solve-2 (input)
  (loop for line in input
	with doit = t
	sum (->> line
	      (ppcre:all-matches-as-strings "(mul\\([0-9]{1,3},[0-9]{1,3}\\))|(do\\(\\))|(don't\\(\\))")
	      (lambda (muls)
		(loop
		  for mul in muls
		  when (ppcre:scan "do\\(\\)" mul)
		    do (setf doit t)
		  when (ppcre:scan "don't\\(\\)" mul)
		    do (setf doit nil)
		  when (and doit (scan "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)" mul))
		    sum (register-groups-bind (a b)
			    ("mul\\(([0-9]{1,3}),([0-9]{1,3})\\)" mul)
			  (* (parse-integer a) (parse-integer b))))))))

#+nil
(solve-2 *sample-2*)

#+nil
(solve-2 *input*)
