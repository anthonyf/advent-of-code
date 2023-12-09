(in-package #:day-09)


(defun parse-input (file)
  (->> file
    read-file-lines
    (map 'list (lambda (line)
		 (->> line
		   (split "\\s")
		   (map 'list (lambda (n)
				(parse-integer n))))))))

(defparameter *sample*
  (parse-input #P "day-09-sample.txt"))

(defparameter *input*
  (parse-input #P "day-09-input.txt"))

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
		   #'diff-seqs
		   #'extrapolate)))
    (reduce #'+)))

(solve-1 *sample*)

(solve-1 *input*)
