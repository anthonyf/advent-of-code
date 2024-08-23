;;;; advent-of-code.asd

#-asdf3.1 (error "LIL requires ASDF 3.1 or later. Please upgrade your ASDF.")

(asdf:defsystem #:advent-of-code
  :description "Describe advent-of-code here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :class :package-inferred-system
  ;; :serial t
  :depends-on (#:advent-of-code/2023/all
	       ;; #:alexandria
	       ;; #:arrow-macros
	       ;; #:cl-ppcre
	       ;; #:iterate
	       ;; #:serapeum
	       ;; #:uiop
	       )
  ;; :components ((:file "package")
  ;; 	       (:file "util")
  ;; 	       (:module "2023"
  ;; 		:components((:file "day-01")
  ;; 			    (:file "day-02")
  ;; 			    (:file "day-03")
  ;; 			    (:file "day-04")
			    
  ;; 			    (:file "day-08")
  ;; 			    (:file "day-09")

  ;; 			    )
  ;; 		))
  )
