(in-package #:advent-of-code-2023-day-03)


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
		     do (progn (push (cons pos-x pos-y) symbol-positions)
			       (funcall update-nums-fun))
		   finally (funcall update-nums-fun))
	  finally (return (list (reverse num-positions)
				(reverse symbol-positions))))))


(defparameter *sample* (parse-file "2023/day-03-sample.txt"))
(defparameter *input* (parse-file "2023/day-03-input.txt"))

(defun valid-number-p (number-positions symbol-positions)
  (loop for (np-x . np-y) in number-positions
	thereis (loop for (sp-x . sp-y) in symbol-positions
		      thereis (loop for (ox oy) in '((-1 -1) (-1 0) (-1 1)
						     (0 -1) (0 1)
						     (1 -1) (1 0) (1 1))
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

