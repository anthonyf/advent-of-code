(uiop:define-package #:aoc/2024/day-05
  (:use #:cl)
  (:import-from #:serapeum
		#:assort)
  (:mix #:aoc/util))

(in-package #:aoc/2024/day-05)

(defun parse-input (str)
  (destructuring-bind (rules updates)
      (ppcre:split "\\n\\n" str)
    (let ((ordering-rules (loop for rule-str in (ppcre:all-matches-as-strings "\\d+\\|\\d+" rules)
				collect (ppcre:register-groups-bind (a b)
					    ("(\\d+)\\|(\\d+)" rule-str)
					  (cons (parse-integer a) (parse-integer b)))))
	  (update-lines (loop for line in (string-lines updates)
			      collect (loop for page-number in (ppcre:all-matches-as-strings "\\d+" line)
					    collect (ppcre:register-groups-bind (a)
							("(\\d+)" page-number)
						      (parse-integer a))))))
      (list ordering-rules update-lines))))

(defparameter *sample* (parse-input "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"))

(defparameter *input* (parse-input (input-string 2024 5)))

(defun pages-after (input page)
  (loop for (a . b) in (first input)
	when (= a page)
	  collect b))

(defun solve-1 (input)
  (loop for pages in (second input)
	when (loop for (page . rest-pages) on (reverse pages)
		   never (loop for other-page in rest-pages
			       thereis (member other-page (pages-after input page) :test #'=)))
	  sum (nth (truncate (/ (length pages)
				2))
		   pages)))

#+nil
(solve-1 *sample*)
 ; => 143 (8 bits, #x8F, #o217, #b10001111)

#+nil
(solve-1 *input*)
 ; => 5762 (13 bits, #x1682)

(defun solve-2 (input)
  (loop for pages in (second input)
	for sorted = (stable-sort (copy-seq pages) (lambda (page other-page)
						     (member other-page
							     (pages-after input page)
							     :test #'=)))
	unless (equal sorted pages)
	  sum (nth (truncate (/ (length sorted)
				2))
		   sorted)
	))

#+nil
(solve-2 *sample*)
 ; => 123 (7 bits, #x7B, #o173, #b1111011)

#+nil
(solve-2 *input*)
 ; => 4130 (13 bits, #x1022)
