(uiop:define-package #:advent-of-code/2023/day-09
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:arrow-macros
	#:cl-ppcre))

(in-package #:advent-of-code/2023/day-09)


(defun parse-lines (lines)
  (->> lines
    (map 'list (lambda (line)
		 (->> line
		   (split "\\s")
		   (map 'list (lambda (n)
				(parse-integer n))))))))

(defparameter *sample*
  (parse-lines (string-lines "0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45")))

(defparameter *input*
  (parse-lines (input-lines 2023 9)))

(defun diff-seq (seq)
  (loop for (a b) on seq by #'cdr
	while (and a b)
	collect (- b a)))

(defun diff-seqs (seq)
  (loop for s = (diff-seq seq)
	then (diff-seq s)
	until (every (lambda (x) (= x 0)) s)
	collect s into a
	finally (return (cons seq (append a (list s))))))

(defun extrapolate (seqs)
  (loop for s in seqs
	sum (car (last s))))

(defun solve-1 (input)
  (->> input
    (map 'list (lambda (line)
		 (->> line
		   diff-seqs
		   extrapolate)))
    (reduce #'+)))


(defun extrapolate-2 (seqs)
  (let* ((start (loop for s in (reverse seqs)
		      collect (first s))))
    (-> (loop for n in (rest start)
	      for x = (- n 0) then (- n x) 
	      collect x)
	last
	car)))

(defun solve-2 (input)
  (->> input
    (map 'list (lambda (line)
		 (->> line
		   diff-seqs
		   extrapolate-2)))
    (reduce #'+)))

(solve-1 *sample*)

(solve-1 *input*)

(solve-2 *sample*)

(solve-2 *input*)
