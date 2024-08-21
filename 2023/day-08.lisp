(in-package #:advent-of-code-2023-day-08)


(defun parse-input (file)
  (let* ((lines (file-lines file))
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
  (parse-input #P "2023/day-08-sample-1.txt"))

(defparameter *sample-2*
  (parse-input #P "2023/day-08-sample-2.txt"))

(defparameter *input*
  (parse-input #P "2023/day-08-input.txt"))

(defun do-step (network current-node dirs dirs-index)
  (let-match* (((cons l r) (gethash current-node network))
		 (next-node (if (equal #\L (aref dirs dirs-index))
				l
				r))
		 (next-dirs-index (mod (1+ dirs-index)
				       (length dirs))))
    (list :current-node next-node :dir-index next-dirs-index)))


(defun steps (network dirs)
  (let ((current-node "AAA")
	(dirs-index 0))
    (loop while (not (equal "ZZZ" current-node))
	  do (match (do-step network current-node dirs dirs-index)
	       ((plist :current-node cn :dir-index di) 
		(setf current-node cn
		      dirs-index di)))
	  count 1)))

(defun solve-1 (input)
 (destructuring-bind (&key directions network) input
   (steps network directions)))


#+nil
(solve-1 *input*)

(defparameter *sample-3*
  (parse-input #P "2023/day-08-sample-3.txt"))


