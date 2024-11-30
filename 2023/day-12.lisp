(uiop:define-package #:aoc/2023/day-12
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2023/day-12)


(defun parse-line (line)
  (destructuring-bind (pattern contiguous-damaged)
      (uiop:split-string line)
    (cons pattern (uiop:split-string contiguous-damaged :separator '(#\,)))))

(-<> "#.#.### 1,1,3
.#...#....###. 1,1,3
.#.###.#.###### 1,3,1,6
####.#...#... 4,1,1
#....######..#####. 1,6,5
.###.##....# 3,2,1"
  string-lines
  (mapcar #'parse-line <>))
