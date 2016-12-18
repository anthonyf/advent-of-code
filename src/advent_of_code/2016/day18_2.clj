(ns advent-of-code.2016.day18-2
  (:require [advent-of-code.2016.day18-1 :as d1]))


(defn solve []
  (d1/count-safe d1/data 400000))

#_ (solve)
;; => 20000795
