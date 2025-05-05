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
	   #:digits->int
	   #:vmap-digit-at
	   #:vmap-neighbors-4
	   #:in-group-p
	   #:merge-groups
	   #:group-add
	   #:group-new
	   #:vmap-all-adjacent-pairs-4
	   #:vmap-find-groups))

(in-package :advent-of-code/util)

(.env:load-env (asdf:system-relative-pathname "advent-of-code" "./.env"))

(defun prompt-for-value (prompt)
  (format *query-io* prompt) ;; *query-io*: the special stream to make user queries.
  (force-output *query-io*)  ;; Ensure the user sees what he types.
  (list (read *query-io*)))

(defun curl-input (year day)
  (let ((aoc-session (uiop:getenv "AOC_SESSION_KEY")))
    (restart-case (assert aoc-session)
      (set-session-id (value)
	:report "Enter a new AoC session ID"
	:interactive (lambda () (prompt-for-value "Enter a new AoC session ID:"))
	(progn
	  (setf aoc-session value)
	  (curl-input year day))))
    (with-output-to-string (out)
      (uiop:run-program (format nil "curl -s -H \"Cookie: session=~A\" \"https://adventofcode.com/~A/day/~A/input\"" aoc-session year day)
			:output out))))

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

(defun vmap-digit-at (vmap pos)
  (- (char-int (vmap-at vmap pos))
     (char-int #\0)))

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

(defun vmap-neighbors-4 (input pos)
  (destructuring-bind (x . y)
      pos
    (loop for (ox . oy) in '(( 0 . -1)
			     ( 1 .  0)
			     ( 0 .  1)
			     (-1 .  0))
	  for npos = (cons (+ x ox) (+ y oy))
	  when (vmap-in-bounds-p input npos)
	    collect npos)))

(defun vmap-from-string (str)
  (-> str string-lines (coerce 'vector)))


(defun in-group-p (groups item &key (test #'eql))
  (loop for group in groups
	when (member item group :test test)
	  return group))

(defun merge-groups (groups group-a group-b)
  (-<> groups
    (remove group-a <> :test #'equal)
    (remove group-b <> :test #'equal)
    (group-new <> (union group-a group-b :test #'equal))))

(defun group-add (groups group item)
  (-<> groups
    (remove group <> :test #'equal)
    (group-new <> (push item group))))

(defun group-new (groups items)
  (push items groups))

#+nil
(-> nil
  (group-new (list 1 2 3))
  (group-new (list 4 5))
  (group-add (list 4 5) 6)
  (group-new (list 7 8 9))
  (merge-groups (list 7 8 9) (list 1 2 3))
  (in-group-p 2))


#+nil
(in-group-p (list (list 1 2 3) (list 4 5 6)) 4)

(defun vmap-all-adjacent-pairs-4 (vmap)
  (loop for y from 0 below (vmap-height vmap)
	append (loop for x from 0 below (vmap-width vmap)
		     when (< (1+ y) (vmap-height vmap))
		       collect (list (cons x y)
				     (cons x (1+ y)))
		     when (< (1+ x) (vmap-width vmap))
		       collect (list (cons x y)
				     (cons (1+ x) y)))))

(defun -vmap-group-pair (vmap pair groups)
  (destructuring-bind (pos1 pos2)
      pair
    (let ((a (vmap-at vmap pos1))
	  (b (vmap-at vmap pos2))
	  (group-a (in-group-p groups pos1 :test #'equal))
	  (group-b (in-group-p groups pos2 :test #'equal)))
      (cond ((eql a b)
	     (cond ((and group-a group-b (not (equal group-a group-b)))
		    ;; a and b are in different groups, merge the groups
		    (setf groups (merge-groups groups group-a group-b)))
		   ((and group-a (not group-b))
		    ;; if a and b are same but b is not in a group, add it to group a
		    (setf groups (group-add groups group-a pos2)))
		   ((and (not group-a) group-b)
		    ;; if a and b are same but a is not in a group, add it to group b
		    (setf groups (group-add groups group-b pos1)))
		   ((and (not group-a) (not group-b))
		    ;; if a and b are same but neither is in a group
		    (setf groups (group-new groups (list pos1 pos2))))))
	    (t
	     ;; if a and b are different, make sure they are both in a group
	     (unless group-a
	       (setf groups (group-new groups (list pos1))))
	     (unless group-b
	       (setf groups (group-new groups (list pos2))))))))
  groups)

(defun vmap-find-groups (vmap)
  (loop for pair in (vmap-all-adjacent-pairs-4 vmap)
	for groups = (-vmap-group-pair vmap pair groups)
	finally (return groups)))

#+nil
(vmap-all-adjacent-pairs-4 (vector (vector 1 2)
				   (vector 3 4)))

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

