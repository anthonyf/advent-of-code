;;;; package.lisp

(uiop:define-package #:advent-of-code-util
  (:use #:cl)
  (:export #:file-lines))

(uiop:define-package #:day-01
  (:use #:cl)
  (:import-from #:advent-of-code-util
		#:file-lines)
  (:import-from #:arrow-macros
		#:<>
		#:-<>)
  (:import-from #:serapeum
		#:filter))

(uiop:define-package #:advent-of-code-2023-day-02
  (:use #:cl)
  (:import-from #:advent-of-code-util
		#:file-lines)
  (:import-from #:ppcre
		#:split
		#:register-groups-bind)
  (:import-from #:cl-ppcre
		#:scan-to-strings)
  (:import-from #:arrow-macros
		#:->>))

(uiop:define-package #:advent-of-code-2023-day-08
  (:use #:cl)
  (:import-from #:advent-of-code-util
		#:file-lines)
  (:import-from #:ppcre
		#:register-groups-bind)
  (:import-from #:trivia
		#:plist
		#:match
		#:let-match*))

(uiop:define-package #:day-09
  (:use #:cl)
  (:import-from #:advent-of-code-util
		#:file-lines)
  (:import-from #:arrow-macros
		#:->
		#:->>)
  (:import-from #:ppcre
		#:split))
