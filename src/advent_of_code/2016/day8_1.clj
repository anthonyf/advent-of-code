(ns advent-of-code.2016.day8-1
  (:require [advent-of-code.2016.day8-data :as d]
            [clojure.string :as str]))

(defn parse-command
  [line]
  (if-let [[_ c a b] (or (re-matches #"(rect) ([0-9]+)x([0-9]+)" line)
                         (re-matches #"(rotate row) y=([0-9]+) by ([0-9]+)" line)
                         (re-matches #"(rotate column) x=([0-9]+) by ([0-9]+)" line))]
    [(case c
       "rect" :rect
       "rotate row" :rotate-row
       "rotate column" :rotate-column)
     (Integer/parseInt a)
     (Integer/parseInt b)]))

#_ (parse-command "rect 10x1")
;; => [:rect 10 1]
#_ (parse-command "rotate row y=0 by 10")
;; => [:rotate-row 0 10]
#_ (parse-command "rotate column x=0 by 10")
;; => [:rotate-column 0 10]



#_ (map parse-command (str/split-lines d/raw-data))
