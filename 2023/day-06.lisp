(uiop:define-package #:advent-of-code/2023/day-06
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate
	#:cl-ppcre
	#:trivia
	#:arrow-macros))

(in-package #:advent-of-code/2023/day-06)

(defun parse-line (str regex)
  (mapcar #'parse-integer
	  (split "\\s+" (register-groups-bind (a)
			    (regex str)
			  a))))

(defun parse-file (file)
  (let* ((str (file-string file))
	 (times (parse-line str "Time:\\s+((\\d+\\s+)+)"))
	 (distances (parse-line str "Distance:\\s+((\\d+\\s+)+)")))
    (list :times times :distances distances)))

#+nil
(parse-file "2023/day-06-sample.txt")

(defparameter *sample* (parse-file "2023/day-06-sample.txt"))
(defparameter *input* (parse-file "2023/day-06-input.txt"))

(defun ways-to-win (race-time record-distance)
  (->> (iter
	 (for button-time from 1 below race-time)
	 (for distance = (* button-time (- race-time button-time)))
	 (when (> distance record-distance)
	   (collecting distance)))
    #'length))

#+nil
(ways-to-win 15 40)

(defun solve-1 (input)
  (let-match (((plist :times times :distances distances) input))
    (iter
      (for time in times)
      (for distance in distances)
      (multiplying (ways-to-win time distance)))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)
