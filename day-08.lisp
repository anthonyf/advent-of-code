(in-package #:day-08)


(defun parse-input (file)
  (let* ((lines (read-file-lines file))
	 (directions (first lines))
	 (rest-lines (cddr lines))
	 (network (let ((network (make-hash-table :test 'equal)))
		    (loop for line in rest-lines
			  do (register-groups-bind (a b c) ("^(\\w+) = \\((\\w+), (\\w+)\\)$" line)
			       (setf (gethash a network) (cons b c))))
		    network)))
    (list :directions directions
	  :network network)))

(defparameter *sample-1*
  (parse-input #P "day-08-sample-1.txt"))

(defparameter *sample-2*
  (parse-input #P "day-08-sample-2.txt"))

(defparameter *input*
  (parse-input #P "day-08-input.txt"))

(defun do-step (network current-node dirs dirs-index)
  (let-match* (((cons l r) (gethash current-node network))
	       (next-node (if (equal #\L (aref dirs dirs-index))
			      l
			      r))
	       (next-dirs-index (mod (1+ dirs-index)
				     (length dirs))))
    (values next-node next-dirs-index)))


(defun steps (network dirs)
  (let ((current-node "AAA")
	(dirs-index 0))
    (loop while (not (equal "ZZZ" current-node))
	  do (multiple-value-bind (cn di)
		 (do-step network current-node dirs dirs-index)
	       (setf current-node cn
		     dirs-index di))
	  count 1)))

(destructuring-bind (&key directions network) *sample-1*
  (multiple-value-list (do-step network "CCC" directions 1)))

(defun solve-1 (input)
 (destructuring-bind (&key directions network) input
   (steps network directions)))


(solve-1 *input*)
