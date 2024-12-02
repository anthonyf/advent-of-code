(uiop:define-package #:aoc/2023/day-12
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros
	#:trivia))

(in-package #:aoc/2023/day-12)

(defun parse-line (line)
  (destructuring-bind (pattern contiguous-damaged)
      (uiop:split-string line)
    (list pattern (mapcar #'parse-integer
			  (uiop:split-string contiguous-damaged
					     :separator '(#\,))))))

(defun parse-lines (lines)
  (mapcar #'parse-line lines))

(defparameter *sample* (parse-lines (string-lines "???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1")))

(defparameter *input* (parse-lines (input-lines 2023 12)))

(defun count-arrangements (records damaged-counts &optional (current-count 0))
  (match (list records damaged-counts)
    ((list (vector) (list))
     1)
    ((guard (list (vector) (list d))
	    (= current-count d))
     1)
    ((list (vector* #\.) (list))
     (count-arrangements (subseq records 1) damaged-counts current-count))
    ((guard (list (vector* #\.) (list* d _))
	    (or (= current-count d)
		(= current-count 0)))
     (count-arrangements (subseq records 1) (if (= current-count d)
						(rest damaged-counts)
						damaged-counts) 0))
    ((guard (list (vector* #\#) (list* d _))
	    (< current-count d))
     (count-arrangements (subseq records 1) damaged-counts (1+ current-count)))
    ((list (vector* #\?) _)
     (+ (count-arrangements (concatenate 'string "#" (subseq records 1))
			    damaged-counts current-count)
	(count-arrangements (concatenate 'string "." (subseq records 1))
			    damaged-counts current-count)))
    (_ 0)))

#+nil
(count-arrangements "????.######..#####." (list 1 6 5))

(defun solve-1 (input)
  (loop for (records damaged-counts) in input
	sum (count-arrangements records damaged-counts)))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)

(defun unfold (records damaged-counts)
  (values (serapeum:string-join (loop repeat 5
				      collect records)
				"?")
	  (loop repeat 5
		append damaged-counts)))

(defun solve-2 (input)
  (loop for (records damaged-counts) in input
	sum (multiple-value-bind (records damaged-counts)
		(unfold records damaged-counts)
	      (count-arrangements records damaged-counts))))

#+nil
(solve-2 *sample*)
