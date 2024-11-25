(uiop:define-package #:advent-of-code/2023/day-10
  (:use #:coalton
	#:coalton-prelude)
  (:local-nicknames (#:u #:aoc/coalton-util)))

(in-package #:advent-of-code/2023/day-10)

(named-readtables:in-readtable coalton:coalton)

(coalton-toplevel

  (define input (u:input-lines 2023 10))

  (define sample (u:string-lines ".....
.S-7.
.|.|.
.L-J.
....."))

  (define (start-position input)
    (coalton-library/string:chars ))
  
  (define (solve-1 _input)
    nil)
  )

#+nil
(coalton sample)

