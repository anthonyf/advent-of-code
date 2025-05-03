(uiop:define-package #:aoc/2024/day-13
  (:use #:cl)
  (:import-from #:serapeum
		#:split-sequence)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-13)

(defparameter *sample* (vmap-from-string "Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279"))

(defparameter *input* (vmap-from-string (input-string 2024 13)))

(defun parse-button (line)
  (ppcre:register-groups-bind (x y) ("Button .: X\\+(\\d+), Y\\+(\\d+)" line)
    (list (parse-integer x) (parse-integer y))))

#+nil
(parse-button "Button A: X+94, Y+34")

(defun parse-prize (line)
  (ppcre:register-groups-bind (x y) ("Prize: X=(\\d+), Y=(\\d+)" line)
    (list (parse-integer x) (parse-integer y))))

#+nil
(parse-prize "Prize: X=8400, Y=5400")

(defun parse-input (input)
  (let ((entries (split-sequence "" input :test #'equal)))
    (loop for entry in entries
	  collect (destructuring-bind (button-a button-b prize) (coerce entry 'list)
		    (append (parse-button button-a)
			    (parse-button button-b)
			    (parse-prize prize))))))

#+nil
(parse-input *sample*)

#+nil
(parse-input *input*)

(defun least-tokens (ax ay bx by px py)
  (loop
    named outer
    for aax from 0 by ax
    for aay from 0 by ay
    for tokens-a from 0
    while (and (<= aax px)
	       (<= aay py))
    do (loop
	 for bbx from 0 by bx
	 for bby from 0 by by
	 for tokens-b from 0
	 while (and (<= (+ aax bbx) px)
		    (<= (+ aay bby) py))
	 when (and (= (+ aax bbx) px)
		   (= (+ aay bby) py))
	   do (return-from outer (+ (* 3 tokens-a) tokens-b)))
    finally (return-from outer 0)))

(defun solve-1 (input)
  (loop for (ax ay bx by px py) in (parse-input input)
	sum (least-tokens ax ay bx by px py)))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)
