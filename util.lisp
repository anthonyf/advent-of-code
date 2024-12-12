(uiop:define-package #:advent-of-code/util
  (:use #:cl)
  (:nicknames #:aoc/util)
  (:mix #:arrow-macros)
  (:export #:input-lines
	   #:input-string
	   #:string-lines
	   #:vmap-width
	   #:vmap-height
	   #:vmap-at
	   #:vmap-in-bounds-p
	   #:vmap-positions
	   #:vmap-from-string
	   #:make-set
	   #:set-contains-p
	   #:set-add
	   #:memoize
	   #:defmemoized
	   #:int->digits
	   #:digits->int))

(in-package :advent-of-code/util)

(.env:load-env (asdf:system-relative-pathname "advent-of-code" "./.env"))

(defvar *aoc-session* (uiop:getenv "AOC_SESSION_KEY"))

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

(defun vmap-width (vmap)
  (length (aref vmap 0)))

(defun vmap-height (vmap)
  (length vmap))


(defun vmap-at (vmap pos)
  (destructuring-bind (x . y)
      pos
    (aref (aref vmap y) x)))

(defun (setf vmap-at) (value vmap pos)
  (destructuring-bind (x . y)
      pos
    (setf (aref (aref vmap y) x)
	  value)))

(defun vmap-in-bounds-p (vmap pos)
  (destructuring-bind (x . y)
      pos
    (and (>= x 0)
	 (< x (vmap-width vmap))
	 (>= y 0)
	 (< y (vmap-height vmap)))))

(defun vmap-positions (vmap)
  (loop for y from 0 below (vmap-height vmap)
	append (loop for x from 0 below (vmap-width vmap)
		     collect (cons x y))))


(defun vmap-from-string (str)
  (-> str string-lines (coerce 'vector)))



(defun make-set (&key (items nil) (test #'eql))
  (let ((ht (make-hash-table :test test)))
    (loop for item in items
	  do (setf (gethash item ht) item))
    ht))

(defun set-contains-p (s item)
  (gethash item s))

(defun set-add (s item)
  (setf (gethash item s) item))

(defun memoize (fn)
  (let ((cache (make-hash-table :test #'equal)))
    #'(lambda (&rest args)
        (multiple-value-bind 
              (result exists)
            (gethash args cache)
          (if exists
              result
              (setf (gethash args cache)
                    (apply fn args)))))))

(defmacro defmemoized (name args &body body)
  `(setf (fdefinition ',name)
	 (memoize #'(lambda ,args
		      ,@body))))

(defun int->digits (n)
  (reverse
   (loop while (> n 0)
	 collect (mod n 10)
	 do (setf n (truncate (/ n 10))))))

(defun digits->int (digits)
  (loop for d in (reverse digits)
	for b = 1 then (* b 10)
	sum (* d b)))

