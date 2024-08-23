(defpackage #:advent-of-code/util
  (:use #:cl)
  (:import-from #:uiop)
  (:import-from #:asdf))

(in-package :advent-of-code/util)

(defun file-lines (file)
  (uiop:read-file-lines
   (asdf:system-relative-pathname :advent-of-code file)))
