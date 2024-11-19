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

(defun parse-str (str)
  (let* ((times (parse-line str "Time:\\s+((\\d+\\s+)+)"))
	 (distances (parse-line str "Distance:\\s+((\\d+\\s+)+)")))
    (list :times times :distances distances)))

#+nil
(parse-file "2023/day-06-sample.txt")

(defparameter *sample* (parse-str "Time:      7  15   30
Distance:  9  40  200"))

(defparameter *input* (parse-str (input-string 2023 6)))

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

(defun concat-numbers (nums)
  (parse-integer
   (apply #'concatenate 'string
	  (mapcar #'write-to-string nums))))

#+nil
(concat-numbers '(10 20 30))

(defun solve-2 (input)
  (let-match* (((plist :times times :distances distances) input)
	       (time (concat-numbers times))
	       (distance (concat-numbers distances)))
    (ways-to-win time distance)))


#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
