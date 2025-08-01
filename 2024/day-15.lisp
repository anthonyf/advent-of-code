(uiop:define-package #:aoc/2023/day-15
  (:use #:cl)
  (:mix #:aoc/util
	#:arrow-macros))

(in-package #:aoc/2023/day-15)

(defun parse-map (str)
  ;; parse the str input into a two-dimensional array
  (let ((lines (string-lines str)))
    (make-array (list (length lines) (length (first lines)))
		:initial-contents lines)))

(defun parse-input (str)
  ;; split the string by double newlines to separate the map and the instructions
  (let* ((parts (ppcre:split "\\n\\n" str))
	 (map (parse-map (first parts)))
	 (moves (second parts)))
    (values map moves)))

(defparameter *large-example* "##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^")

(defparameter *small-example* "########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<")

#+nil
(multiple-value-bind (map moves) (parse-input *small-example*)
  (aref map 2 2)
  ;;moves
  )

(defun sum-of-all-box-coordinates (map)
  "Sum the coordinates of all boxes in the map."
  (loop for i from 0 below (array-dimension map 0)
	for j from 0 below (array-dimension map 1)
	when (char= (aref map i j) #\O)
	  sum (+ (* 100 i) j)))

(defun robot-position (map)
  "Find the robot's position in the map."
  (loop for i from 0 below (array-dimension map 0)
	for j from 0 below (array-dimension map 1)
	when (char= (aref map i j) #\@)
	  return (cons i j)))

(defun move (map move pos)
  )

(defun solve-1 (input)
  (multiple-value-bind (map moves)
      (parse-input input)
    (loop
      with pos = (robot-position map)
      for move across moves
      do (setf pos (move map move pos)))
    (sum-of-all-box-coordinates map)))
