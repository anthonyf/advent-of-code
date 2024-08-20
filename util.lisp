(in-package :advent-of-code-util)

(defun file-lines (file)
  (uiop:read-file-lines
   (asdf:system-relative-pathname :advent-of-code file)))
