(uiop:define-package #:aoc/2024/day-11
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2024/day-11)

(defun parse-data (str)
  (->> str
    (ppcre:split " ")
    (mapcar #'parse-integer)))

(defparameter *sample* (parse-data "0 1 10 99 999"))

(defparameter *input* (parse-data (input-string 2024 11)))

(defun split-rock (rock)
  (let* ((digits (int->digits rock))
	 (half (/ (length digits) 2))
	 (a (digits->int (subseq digits 0 half)))
	 (b (digits->int (subseq digits half))))
    (list a b)))

(defmemoized blink (rock n)
  (if (zerop n)
      1
      (cond ((= 0 rock)
	     (blink 1 (1- n)))
	    ((evenp (length (int->digits rock)))
	     (destructuring-bind (a b)
		 (split-rock rock)
	       (+ (blink a (1- n))
		  (blink b (1- n)))))
	    (t
	     (blink (* rock 2024) (1- n))))))

(defun solve-1 (input)
  (loop for n in input
	sum (blink n 25)))

#+nil
(solve-1 *input*)
 ; => 199986 (18 bits, #x30D32)

(defun solve-2 (input)
  (loop for n in input
	sum (blink n 75)))

#+nil
(solve-2 *input*)
 ; => 236804088748754 (48 bits, #xD75F3F975AD2)

