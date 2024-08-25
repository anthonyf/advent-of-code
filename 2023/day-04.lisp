(uiop:define-package #:advent-of-code/2023/day-04
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:arrow-macros
	#:trivia
	#:iterate
	#:serapeum))


(in-package #:advent-of-code/2023/day-04)

(defun string-to-integer-list (str)
  (mapcar #'parse-integer
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
  (iter
    (for (nil winning have) in data)
    (for intersection = (intersection winning have))
    (summing (points (length intersection)))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)

(defstruct card id count winning have)

(defun cards-by-num (data)
  (iter
    (with d = (dict))
    (for (card-num winning have) in data)
    (setf (gethash card-num d) (make-card :count 1 :id card-num :winning winning :have have))
    (finally (return d))))

#+nil
(gethash 1 (cards-by-num *sample*))


(defun inc-cards (cards-by-num start-card len n)
  (iter
    (for i from start-card below (+ start-card len))
    (incf (card-count (gethash i cards-by-num)) n)))

#+nil
(let ((a (cards-by-num *sample*)))
  (inc-cards a 2 3)
  (list (gethash 1 a)
	(gethash 2 a)
	(gethash 3 a)
	(gethash 4 a)
	(gethash 5 a)
	(gethash 6 a)
	(gethash 7 a)))


(defun solve-2 (data)
  (let ((cards-by-num (cards-by-num data)))
    (iter
      (for (card-id card) in-hashtable cards-by-num)
      (for intersecting = (length (intersection (card-winning card)
						(card-have card))))
      (if (> intersecting 0)
	  (inc-cards cards-by-num (1+ card-id) intersecting (card-count card))))
    (iter
      (for (card-id card) in-hashtable cards-by-num)
      (summing (card-count card)))))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
