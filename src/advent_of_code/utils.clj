(ns advent-of-code.utils
  (:import (java.io BufferedReader StringReader)))

(defn string-line-seq
  [s]
  (line-seq (BufferedReader. (StringReader. s))))
