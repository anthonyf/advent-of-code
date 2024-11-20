(uiop:define-package #:advent-of-code/2023/day-07
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate
	#:serapeum
	#:cl-ppcre
	#:trivia))

(in-package #:advent-of-code/2023/day-07)

(defun parse-lines (lines)
  (~>> lines
       (mapcar (lambda (line)
		 (let-match (((list cards bid) (split "\\s" line)))
		   (cons cards (parse-integer bid)))))))
#+nil
(parse-file "2023/day-07-sample.txt")

(defparameter *sample* (parse-lines (string-lines "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483")))

(defparameter *input* (parse-lines (input-lines 2023 7)))

(defparameter *hands* (reverse (vector :five-of-a-kind :four-of-a-kind :full-house :three-of-a-kind :two-pair :one-pair :high-card)))

(defparameter *cards* (reverse (vector #\A #\K #\Q #\J #\T #\9 #\8 #\7 #\6 #\5 #\4 #\3 #\2)))

(defun hand-type (cards)
  (let* ((groups (sort (mapcar #'length (assort cards)) #'<)))
    (ematch groups
      ((list 5) :five-of-a-kind)
      ((list 1 4) :four-of-a-kind)
      ((list 2 3) :full-house)
      ((list 1 1 3) :three-of-a-kind)
      ((list 1 2 2) :two-pair)
      ((list 1 1 1 2) :one-pair)
      ((list 1 1 1 1 1) :high-card))))

(defun hand-score (hand-type cards)
  (let ((base (length *cards*)))
    (+ (* (position hand-type *hands*)
	  (expt base 5))
       (iter
	 (for i from 4 downto 0)
	 (for card in-vector cards)
	 (for p = (position card *cards*))
	 (for d = (* p (expt base i)))
	 (sum d)))))

#+nil
(hand-score :two-pair "KTJJT")

(defun solve-1 (input)
  (let* ((hands (iter (for (cards . bid) in input)
		  (collect (list (hand-type cards) cards bid))))
	 (hands (iter (for (hand-type cards bid) in hands )
		  (collect (list (hand-score hand-type cards) hand-type cards bid))))
	 (hands-sorted (sort hands #'< :key #'car)))
    
    (iter
      (for i from 1)
      (for (nil nil nil bid) in hands-sorted)
      (sum (* i bid)))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)
