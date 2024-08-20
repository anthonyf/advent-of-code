;;;; package.lisp

(uiop:define-package #:advent-of-code-util
  (:use #:cl)
  (:export #:file-lines))

(uiop:define-package #:day-01
  (:use #:cl)
  (:local-nicknames (#:u #:advent-of-code-util)
		    (#:a #:arrow-macros)
		    (#:s #:serapeum)))

(uiop:define-package #:day-02
  (:use #:cl #:uiop #:arrow-macros #:trivia
	#:ppcre)
  (:shadowing-import-from #:trivia :<>))

(uiop:define-package #:advent-of-code-2023-day-08
  (:use #:cl)
  (:local-nicknames (#:u #:advent-of-code-util)
		    (#:a #:arrow-macros)
		    (#:s #:serapeum)
		    (#:p #:ppcre)
		    (#:t #:trivia)))

(uiop:define-package #:day-09
  (:use #:cl #:uiop #:arrow-macros #:trivia
	#:ppcre )
  (:shadowing-import-from #:arrow-macros :<>))
