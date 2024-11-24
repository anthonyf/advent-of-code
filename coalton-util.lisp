(uiop:define-package #:aoc/coalton-util
  (:use #:coalton
	#:coalton-prelude)
  (:local-nicknames (#:u #:aoc/util))
  (:export #:input-lines
	   ))

(in-package #:aoc/coalton-util)

(coalton-toplevel

  (define (input-lines year day)
    (lisp (List string) (year day)
      (u:input-lines year day)))
  )
