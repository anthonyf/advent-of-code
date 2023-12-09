;;;; package.lisp

(defpackage #:advent-of-code-2023
  (:use #:cl))

(defpackage #:util
  (:use #:cl #:uiop))

(defpackage #:day-01
  (:use #:cl #:uiop #:advent-of-code-2023 #:arrow-macros))

(defpackage #:day-02
  (:use #:cl #:uiop #:advent-of-code-2023 #:arrow-macros #:trivia
	#:ppcre)
  (:shadowing-import-from #:trivia :<>))

(defpackage #:day-08
  (:use #:cl #:uiop #:advent-of-code-2023 #:arrow-macros #:trivia
	#:ppcre)
  (:shadowing-import-from #:trivia :<>))

(defpackage #:day-09
  (:use #:cl #:uiop #:advent-of-code-2023 #:arrow-macros #:trivia
	#:ppcre)
  (:shadowing-import-from #:arrow-macros :<>))
