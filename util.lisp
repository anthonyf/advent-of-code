(uiop:define-package #:advent-of-code/util
  (:use #:cl)
  (:nicknames #:aoc/util)
  (:import-from #:uiop)
  (:import-from #:asdf)
  (:export #:input-lines
	   #:input-string
	   #:string-lines))

(in-package :advent-of-code/util)

(defvar *aoc-session* nil)

(defun prompt-for-value (prompt)
  (format *query-io* prompt) ;; *query-io*: the special stream to make user queries.
  (force-output *query-io*)  ;; Ensure the user sees what he types.
  (list (read *query-io*)))

(defun curl-input (year day)
  (restart-case (assert *aoc-session*)
    (set-session-id (value)
      :report "Enter a new AoC session ID"
      :interactive (lambda () (prompt-for-value "Enter a new AoC session ID:"))
      (progn
	(setf *aoc-session* value)
	(curl-input year day))))
  (with-output-to-string (out)
    (uiop:run-program (format nil "curl -s -H \"Cookie: session=~A\" \"https://adventofcode.com/~A/day/~A/input\"" *aoc-session* year day)
		      :output out)))

(defun input-string (year day)
  (curl-input year day))

(defun string-lines (str)
  (with-input-from-string (in str)
    (loop for line = (read-line in nil)
	  while line
	  collect line)))

(defun input-lines (year day)
  (string-lines (curl-input year day)))
