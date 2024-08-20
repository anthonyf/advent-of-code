;;;; advent-of-code.asd

(asdf:defsystem #:advent-of-code
  :description "Describe advent-of-code here"
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
	       (:module "2023"
		:components((:file "day-01")
			    (:file "day-02")
			    (:file "day-08")
			    (:file "day-09"))
		)))
