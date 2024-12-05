;;;; advent-of-code.asd

#-asdf3.1 (error "LIL requires ASDF 3.1 or later. Please upgrade your ASDF.")

(asdf:defsystem #:advent-of-code
		:description "Describe advent-of-code here"
		:author "Your Name <your.name@example.com>"
		:license  "Specify license here"
		:version "0.0.1"
		:depends-on (#:cl-dotenv
			     #:coalton
			     #:alexandria
			     #:serapeum
			     #:trivia
			     #:arrow-macros
			     #:cl-ppcre)
		:serial t
		:components ((:file "util")
			     (:file "coalton-util")
			     (:module "2023"
				      :components ((:file "day-01") ;; **
						   (:file "day-02") ;; **
						   (:file "day-03") ;; **
						   (:file "day-04") ;; **
						   (:file "day-05") ;; **
						   (:file "day-06") ;; **
						   (:file "day-07") ;; **
						   (:file "day-08") ;; *
						   (:file "day-09") ;; **
						   (:file "day-10") ;;
						   (:file "day-11") ;; **
						   ;;(:file "day-12") ;; *
						   ))
			     (:module "2024"
				      :components ((:file "day-01") ;; **
						   (:file "day-02") ;; **
						   (:file "day-03") ;; **
						   (:file "day-04") ;; **
						   ))))
