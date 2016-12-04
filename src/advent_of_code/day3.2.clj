(ns advent-of-code.day3.2
  (:require [advent-of-code.day3.1 :as d3.1]))

(def triangles (mapcat (fn [[[a b c]
                             [d e f]
                             [g h i]]]
                         [[a d g]
                          [b e h]
                          [c f i]])
                  (partition 3 d3.1/triangles)))

#_ triangles

(defn solve
  []
  (reduce (fn [sum [a b c]]
            (if (d3.1/triangle? a b c)
              (+ sum 1)
              sum))
          0
          triangles))

#_ (solve)
