(uiop:define-package #:advent-of-code/2023/day-07
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate
	#:arrow-macros
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

(defparameter *all-cards* (reverse (vector #\A #\K #\Q #\J #\T #\9 #\8 #\7 #\6 #\5 #\4 #\3 #\2)))

(defun hand-type (cards)
  (let ((groups (sort (mapcar #'length (assort cards)) #'<)))
    (ematch groups
      ((list 5) :five-of-a-kind)
      ((list 1 4) :four-of-a-kind)
      ((list 2 3) :full-house)
      ((list 1 1 3) :three-of-a-kind)
      ((list 1 2 2) :two-pair)
      ((list 1 1 1 2) :one-pair)
      ((list 1 1 1 1 1) :high-card))))

(defun hand-score (hand-type cards)
  (let ((base (length *all-cards*)))
    (+ (* (position hand-type *hands*)
	  (expt base 5))
       (iter
	 (for i from 4 downto 0)
	 (for card in-vector cards)
	 (for p = (position card *all-cards*))
	 (for d = (* p (expt base i)))
	 (sum d)))))

#+nil
(hand-score :two-pair "KTJJT")

(defun solve-1 (input &optional (hand-type-fun #'hand-type))
  (let* ((hands (iter (for (cards . bid) in input)
		  (collect (list (funcall hand-type-fun cards) cards bid))))
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


(defun most-common-card (cards)
  (let ((cards (remove #\J cards)))
    (if (= 0 (length cards))
	#\K ;; doesn't matter, return some valid card
	(-<> cards
	  assort
	  (stable-sort #'> :key #'length)
	  first
	  (elt 0)))))

#+nil
(most-common-card "jabcd")

(string-replace-all (string #\J) "123J4" (string (most-common-card "123J4")))

(defun hand-type-2 (cards)
  (hand-type (if (string-contains-p "j" cards)
		 (let* ((j-replacement (most-common-card cards)))
		   (string-replace-all (string #\J) cards  (string j-replacement)))
		 cards)))

#+nil
(hand-type-2 "J22J4")

(defun solve-2 (input)
  (let ((*all-cards* (reverse (vector #\A #\K #\Q #\T #\9 #\8 #\7 #\6 #\5 #\4 #\3 #\2 #\J))))
    (solve-1 input #'hand-type-2)))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
