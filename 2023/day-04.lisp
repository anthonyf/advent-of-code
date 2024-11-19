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

(defun parse-lines (lines)
  (loop for line in lines
	collect (parse-line line)))

(defparameter *sample* (parse-lines (string-lines "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11")))

(defparameter *input* (parse-lines (input-lines 2023 4)))

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
