(in-package #:advent-of-code-2023-day-02)


(defparameter *sample*
  (file-lines #P "2023/day-02-sample.txt"))
(multiple-value-list 
 (scan-to-strings "^Game (\\d+):(?:(\\s(?:\\d+) (\\w+),?)+;?)+$"
			 "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))

(defun parse-line (line)
  (register-groups-bind (game right) ("^Game (\\d):(.*)$" line)
    (let ((sets (->> right
		  (split ";")
		  (map 'list (lambda (s)
			       (->> s
				 (split ",")
				 (map 'list (lambda (s)
					      (register-groups-bind (n color)
						  ("\\s*(\\d+) (\\w+)" s)
						(list (intern (string-upcase color) "KEYWORD")
						      (parse-integer n))))
				      ))))))
	  )
      (list game sets))))

(parse-line "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")

