(uiop:define-package #:advent-of-code/2023/all
  (:use #:cl)
  (:mix #:advent-of-code/util)
  (:mix-reexport #:advent-of-code/2023/day-01
		 #:advent-of-code/2023/day-02
		 #:advent-of-code/2023/day-03
		 #:advent-of-code/2023/day-04

		 #:advent-of-code/2023/day-08
		 #:advent-of-code/2023/day-09)
  )

(in-package #:advent-of-code/2023/all)
