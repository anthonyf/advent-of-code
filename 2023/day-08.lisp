(uiop:define-package #:advent-of-code/2023/day-08
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:cl-ppcre
	#:trivia))

(in-package #:advent-of-code/2023/day-08)

(defun parse-lines (lines)
  (let* ((directions (first lines))
	 (rest-lines (cddr lines))
	 (network (let ((network (make-hash-table :test 'equal)))
		    (loop for line in rest-lines
			  do (register-groups-bind (a b c) ("^(\\w+) = \\((\\w+), (\\w+)\\)$" line)
			       (setf (gethash a network) (cons b c))))
		    network)))
    (list :directions directions
	  :network network)))

(defparameter *sample-1*
  (parse-lines (string-lines "RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)")))

(defparameter *sample-2*
  (parse-lines (string-lines "LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)")))

(defparameter *input*
  (parse-lines (input-lines 2023 8)))

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
  (parse-lines (string-lines "LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
")))


