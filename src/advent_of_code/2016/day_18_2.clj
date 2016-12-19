(ns advent-of-code.2016.day-18-2
  (:require [advent-of-code.2016.day-18-1 :as d1]))


(defn solve []
  (d1/safe-traps d1/data 400000))

#_ (solve)
;; => 20000795
