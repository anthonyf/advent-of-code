(uiop:define-package #:advent-of-code/2023/day-07
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate
	#:serapeum
	#:cl-ppcre
	#:trivia))

(in-package #:advent-of-code/2023/day-07)

(defun parse-file (file)
  (~>> file
       (file-lines)
       (mapcar (lambda (line)
		 (let-match (((list cards bid) (split "\\s" line)))
		   (cons cards (parse-integer bid)))))))
#+nil
(parse-file "2023/day-07-sample.txt")

(defparameter *sample* (parse-file "2023/day-07-sample.txt"))
(defparameter *input* (parse-file "2023/day-07-input.txt"))

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
      ((list 1 1 1 2) :pair)
      ((list 1 1 1 1 1) :high-card))))

(defun-ematch hand-score (card)
  ((list hand-type cards _)
   (+ (* (position hand-type *hands*) (expt (length *cards*) 5))
      (iter
	(for i from 0)
	(for card in cards)
	(for p = (position card *cards*))
	(for d = (+ p (expt (length *cards*) i)))
	(sum d)))))

(defun solve-1 (input)
  (let ((hands (iter (for (cards . bid) in input)
		 (collect (list (hand-type cards) cards bid)))))
    (sort hands #'>)))

#+nil
(solve-1 *sample*)
