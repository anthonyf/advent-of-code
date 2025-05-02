(uiop:define-package #:advent-of-code/2023/day-02
  (:use #:cl)
  (:use #:advent-of-code/util
	#:cl-ppcre
	#:arrow-macros))

(in-package #:advent-of-code/2023/day-02)

(declaim (optimize (debug 3)))


(defun parse-line (line)
  #+sbcl (declare (sb-ext:muffle-conditions style-warning))
  (register-groups-bind (game right) ("^Game (\\d+):(.*)$" line)
    (let ((game (parse-integer game))
          (sets (->> right
		  (split ";")
		  (map 'list (lambda (s)
			       (->> (split "," s)
				 (map 'list (lambda (s)
					      (register-groups-bind (n color)
						  ("\\s*(\\d+) (\\w+)" s)
						(list (intern (string-upcase color) "KEYWORD")
						      (parse-integer n))))
				      )))))))
      (list game sets))))

(defun parse-lines (lines)
  (->> lines
    (map 'list #'parse-line)))

(defparameter *sample* (parse-lines (string-lines "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green")))

(defparameter *input* (parse-lines (input-lines 2023 2)))


#+nil
(parse-line "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

#+nil
(print *sample*)

(let ((blue-max 14)
      (green-max 13)
      (red-max 12))
  (defun game-possible-p (data)
    (loop for round in data
	  always (loop for (color count) in round
		       always (case color
				(:blue (<= count blue-max))
				(:red (<= count red-max))
				(:green (<= count green-max)))))))

#+nil
(game-possible-p (cadr (fourth *sample*)))

(defun solve-1 (input)
  (loop for (game data) in input
	for possible-p = (game-possible-p data) 
	when possible-p
	  sum game))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)

(defun lowest-possible (data)
  (loop for round in data
	with (max-red max-blue max-green) = (list 0 0 0)
	do (loop for (color count) in round
		      collect (case color
				(:blue (setf max-blue (max max-blue count)))
				(:red (setf max-red (max max-red count)))
				(:green (setf max-green (max max-green count)))))
	finally (return (list max-red max-blue max-green))))

(defun solve-2 (input)
  (loop for (game data) in input
	sum (apply #'* (lowest-possible data))))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
