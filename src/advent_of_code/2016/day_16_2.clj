(ns advent-of-code.2016.day-16-2
  (:require [advent-of-code.2016.day-16-1 :as d1]))

(defn solve
  []
  (d1/checksum (d1/fill-disk "00101000101111010" 35651584)))

#_ (solve)
;; => "01100100101101100"
