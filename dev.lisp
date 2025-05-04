(ql:quickload :qlot)
(qlot:init (uiop:getcwd))
(pushnew (uiop:getcwd)
	 ql:*local-project-directories*
	 :test #'equalp)

(asdf:load-system "advent-of-code")
