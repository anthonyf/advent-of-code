(uiop:define-package #:advent-of-code/2023/day-07
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate
	#:cl-ppcre
	#:trivia))

(in-package #:advent-of-code/2023/day-07)

(defun parse-file (file)
  (serapeum:~>>
   file
   (file-lines)
   (mapcar (lambda (line)
	     (let-match (((list cards score) (split "\\s" line)))
	       (list :cards cards :score (parse-integer score)))))))


#+nil
(parse-file "2023/day-07-sample.txt")
