;;;; advent-of-code-2023.asd

(asdf:defsystem #:advent-of-code-2023
  :description "Describe advent-of-code-2023 here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:arrow-macros
	       #:alexandria
	       #:serapeum
	       #:uiop
	       #:cl-ppcre)
  :components ((:file "package")
               (:file "advent-of-code-2023")
	       (:file "day-01")))
