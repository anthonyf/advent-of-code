(uiop:define-package #:aoc/coalton-util
  (:use #:coalton
	#:coalton-prelude)
  (:local-nicknames (#:u #:aoc/util))
  (:export #:input-lines
	   #:string-lines))

(in-package #:aoc/coalton-util)

(coalton-toplevel

  (define (input-lines year day)
    (lisp (List string) (year day)
      (u:input-lines year day)))

  (define (string-lines str)
    (lisp (List string) (str)
      (u:string-lines str)))
  )
