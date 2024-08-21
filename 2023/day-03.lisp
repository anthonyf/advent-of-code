(uiop:define-package #:advent-of-code/2023/day-03
  (:use #:cl)
  (:import-from #:advent-of-code/util
		#:file-lines))

(in-package #:advent-of-code/2023/day-03)

(declaim (optimize (debug 3)))

(defstruct num-node
  num
  positions)

(defun parse-file (file)
  (let ((lines (file-lines file)))
    (loop for line in lines
	  for pos-y = 0 then (incf pos-y)
	  with digits = nil
	  with positions = nil
	  with symbol-positions = nil
	  with num-positions = nil
	  with update-nums-fun = (lambda ()
				   (when digits
				     (push (make-num-node :num (parse-integer (concatenate 'string (reverse digits)))
							  :positions positions)
					   num-positions)
				     (setf digits nil
					   positions nil)))
	  do (loop for char across line
		   for pos-x = 0 then (incf pos-x)
		   if (digit-char-p char)
		     do (progn (push char digits)
			       (push (cons pos-x pos-y) positions))
		   else if (eql #\. char)
			  do (funcall update-nums-fun)
		   else
		     do (progn (push (list char pos-x pos-y) symbol-positions)
			       (funcall update-nums-fun))
		   finally (funcall update-nums-fun))
	  finally (return (list (reverse num-positions)
				(reverse symbol-positions))))))


(defparameter *sample* (parse-file "2023/day-03-sample.txt"))
(defparameter *input* (parse-file "2023/day-03-input.txt"))

(defparameter *offsets* '((-1 -1) (-1 0) (-1 1)
			  (0 -1) (0 1)
			  (1 -1) (1 0) (1 1)))

(defun valid-number-p (number-positions symbol-positions)
  (loop for (np-x . np-y) in number-positions
	thereis (loop for (char sp-x sp-y) in symbol-positions
		      thereis (loop for (ox oy) in *offsets*
				    thereis (and (= sp-x (+ ox np-x))
						 (= sp-y (+ oy np-y)))))))

#+nil
(valid-number-p  '((2 . 0) (1 . 0) (0 . 0))
		 '((3 . 1) (6 . 3) (3 . 4) (5 . 5) (3 . 8) (5 . 8)))

(defun solve-1 (data)
  (destructuring-bind (nums symbol-positions)
      data
    (loop for num in nums
	  if (valid-number-p (num-node-positions num) symbol-positions)
	    sum (num-node-num num))))

#+nil
(solve-1 *sample*)

#+nil
(solve-1 *input*)

(defun adjacent-numbers (data sp-x sp-y)
  (destructuring-bind (nums symbol-positions)
      data
    (declare (ignore symbol-positions))
    (loop for num in nums
	  when (loop for (np-x . np-y) in (num-node-positions num)
		     thereis (loop for (ox oy) in *offsets*
				   thereis (and (= sp-x (+ ox np-x))
						(= sp-y (+ oy np-y)))))
	    collect num)))

(defun solve-2 (data)
  (destructuring-bind (nums symbol-positions)
      data
    (declare (ignore nums))
    (loop for (sym sp-x sp-y) in symbol-positions
	  for nums = (adjacent-numbers data sp-x sp-y)
	  when (= 2 (length nums))
	    sum (* (num-node-num (first nums))
		   (num-node-num (second nums))))))

#+nil
(solve-2 *sample*)

#+nil
(solve-2 *input*)
