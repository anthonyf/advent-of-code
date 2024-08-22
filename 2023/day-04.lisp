(in-package #:advent-of-code-2023-day-04)

(defun string-to-integer-list (str)
  (map 'list #'parse-integer
       (ppcre:split "\\s+" (string-trim '(#\space) str))))

(defun parse-line (str)
  (trivia:let-match* (((list card winning have) (uiop:split-string str :separator '(#\: #\|)))
		      (card (parse-integer (subseq card 5)))
		      (winning (string-to-integer-list winning))
		      (have (string-to-integer-list have)))
    (list card winning have)))

#+nil
(parse-line "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")

(defun parse-file (file)
  (loop for line in (file-lines file)
	collect (parse-line line)))

#+nil
(parse-file "2023/day-04-sample.txt")

(defparameter *sample* (parse-file "2023/day-04-sample.txt"))
(defparameter *input* (parse-file "2023/day-04-input.txt"))

(defun points (n)
  (if (= 0 n)
      0
      (expt 2 (- n 1))))

#+nil
(points 0)

(defun solve-1 (data)
  (loop for (card winning have) in data
	for intersection = (intersection winning have)
	sum (points (length intersection))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)
