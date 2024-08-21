(in-package #:advent-of-code-2023-day-02)

(declaim (optimize (debug 3)))


(defun parse-line (line)
  (declare (sb-ext:muffle-conditions style-warning))
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

(defun parse-file (file)
  (->> (file-lines file)
    (map 'list #'parse-line)))

(defparameter *sample* (parse-file #P "2023/day-02-sample.txt"))
(defparameter *input* (parse-file #P "2023/day-02-input.txt"))


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
(print *input*)
(solve-1 *input*)

