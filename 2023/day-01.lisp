(in-package #:day-01)

(defparameter *sample*
 (u:file-lines #p "2023/day-01-sample.txt"))

(defparameter *sample2*
 (u:file-lines #p "2023/day-01-sample2.txt"))

(defparameter *input*
  (u:file-lines #p "2023/day-01-input.txt"))

(defun solve-line (line)
  (loop with first = nil
	with last = nil
	for c across line
	when (digit-char-p c)
	  do (setf last c)
	when (and (digit-char-p c)
		  (not first))
	  do (setf first c)
	finally (return (+ (* 10 (parse-integer (string first)))
			   (parse-integer (string last))))))

(defun solve-1 (lines)
  (loop for line in lines
	sum (solve-line line)))


(defparameter *names* '(("one" . "1")
			("two" . "2")
			("three" . "3")
			("four" . "4")
			("five" . "5")
			("six" . "6")
			("seven" . "7")
			("eight" . "8")
			("nine" . "9")))

(defun indexes (line &key from-end)
  (a:-<> (loop for (s . c) in *names*
	 append (append (list (list s c (search s line :from-end from-end)))
			(list (list s c (search c line :from-end from-end)))))
    (s:filter #'third a:<>)
    (sort a:<> (if from-end #'> #'<) :key #'third)
    first
    second
    parse-integer))

(defun num (line)
  (+ (* 10 (indexes line))
     (indexes line :from-end t)))

(defun solve-2 (lines)
  (loop for line in lines
	sum (num line)))

(solve-1 *sample*)

(solve-1 *input*)

(solve-2 *sample2*)

(solve-2 *input*)
