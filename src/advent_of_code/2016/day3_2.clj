(ns advent-of-code.2016.day3-2
  (:require [advent-of-code.2016.day3-1 :as d3-1]))

(def triangles (mapcat (fn [[[a b c]
                             [d e f]
                             [g h i]]]
                         [[a d g]
                          [b e h]
                          [c f i]])
                       (partition 3 d3-1/triangles)))

#_ (take 4 triangles)
;; => ([330 769 930] [143 547 625] [338 83 317] [669 15 662])

(defn solve
  []
  (reduce (fn [sum [a b c]]
            (if (d3-1/triangle? a b c)
              (+ sum 1)
              sum))
          0
          triangles))

#_ (solve)
;; => 1649
