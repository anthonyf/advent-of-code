(uiop:define-package #:aoc/2023/day-12
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2023/day-12)

(defparameter *sample* (string-lines "???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1"))


(defun parse-line (line)
  (destructuring-bind (pattern contiguous-damaged)
      (uiop:split-string line)
    (list pattern (mapcar #'parse-integer
			  (uiop:split-string contiguous-damaged
					     :separator '(#\,))))))


(defun parse-lines (lines)
  (mapcar #'parse-line lines))

#+nil
(parse-lines *sample*)

(concatenate 'string "b" (subseq "hello" 1))

(defun count-arrangements (records damaged-counts)
  (let ()
    (cond
      ((and (= 0 (length records))
	    (null damaged-counts))
       1)
      
      ((or (= 0 (length records))
	   (null damaged-counts))
       0)
      ((eql #\. (aref records 0))
       (count-arrangements (subseq records 1) damaged-counts))
      ((eql #\# (aref records 0))
       (count-arrangements (subseq records 1) (if (= 1 (first damaged-counts))
						  (rest damaged-counts)
						  (cons (1- (first damaged-counts))
							(rest damaged-counts)))))
      ((eql #\? (aref records 0))
       (+ (count-arrangements (concatenate 'string "." (subseq records 1))
			      damaged-counts)
	  (count-arrangements (concatenate 'string "#" (subseq records 1))
			      damaged-counts))))))

#+nil
(count-arrangements "???.###" '(1 1 3))
