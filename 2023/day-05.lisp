(declaim (optimize (speed 3) (debug 0)))

(uiop:define-package #:advent-of-code/2023/day-05
  (:use #:cl)
  (:mix #:advent-of-code/util
	#:iterate
	#:trivia
	#:cl-ppcre
	#:arrow-macros))

(in-package #:advent-of-code/2023/day-05)


(defun parse-input (str)
  (let*  ((sections (split  "\\n\\n"  str))
	  (seeds (register-groups-bind (a nil)
		     ("seeds: ((\\d+\\s?)+)" (first sections))
		   (mapcar #'parse-integer (split "\\s" a))))
	  (maps (mapcan #'(lambda (section)
			    (register-groups-bind (name triplets)
				("([a-z-]+) map:\\n(((\\d+\\s?))+)" section)
			      (list (intern (string-upcase name) :keyword)
				    (mapcar #'(lambda (line)
							  (mapcar #'parse-integer (split "\\s" line)))
						      (split "\\n" triplets)))))
			(rest sections))))
    (list :seeds seeds
	  :maps maps)))

#+nil
(parse-input "2023/day-05-sample.txt")

(defparameter *sample* (parse-input "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4"))

(defparameter *input* (parse-input (input-string 2023 5)))

(defun map-triplets (triplets seed)
  (iter
    (for (dest-range-start src-range-start length) in triplets)
    (for src-range-end = (+ src-range-start length))
    (when (and (>= seed src-range-start)
	       (<= seed src-range-end))
      (let ((offset (- seed src-range-start)))
	(leave (+ dest-range-start offset))))
    (finally (return seed))))

#+nil
(map-triplets '((50 98 2) (52 50 48)) 79)

(defun map-from (input map-name n)
  (let-match (((plist :maps (plist map-name triplets)) input))
    (map-triplets triplets n)))

#+nil
(map-from *sample* :seed-to-soil 14)

(defun map-seed-to-location (seed input)
  (->> seed
    (map-from input :seed-to-soil)
    (map-from input :soil-to-fertilizer)
    (map-from input :fertilizer-to-water)
    (map-from input :water-to-light)
    (map-from input :light-to-temperature)
    (map-from input :temperature-to-humidity)
    (map-from input :humidity-to-location)))

#+nil
(map-seed-to-location 14 *sample*)

(defun solve-1 (input)
  (let-match (((plist :seeds seeds) input))
    (iter
      (for seed in seeds)
      (minimizing (map-seed-to-location seed input)))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)

(defun solve-2 (input)
  (let-match* (((plist :seeds seeds) input)
	       (seed-ranges (iter
			      (for (s l) on seeds by #'cddr)
			      (collect (list s (+ s l))))))
    (iter
      (for (start end) in seed-ranges)
      (minimizing (iter
		    (for seed from start to end)
		    (minimizing (map-seed-to-location seed input)))))))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
