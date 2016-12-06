(ns advent-of-code.2015.day3-2
  (:require [advent-of-code.2015.day3-data :as d]))

(partition 2 [1 2 3 4 5])

(defn move
  [dir x y]
  (case dir
    \> [(inc x) y]
    \^ [x (dec y)]
    \< [(dec x) y]
    \v [x (inc y)]))

(defn solve
  [raw-data]
  (let [[m _] (reduce (fn [[m [x1 y1][x2 y2]] [d1 d2]]
                        (let [[nx1 ny1] (move d1 x1 y1)
                              [nx2 ny2] (move d2 x2 y2)]
                          [(-> m
                               (conj [nx1 ny1])
                               (conj [nx2 ny2]))
                           [nx1 ny1]
                           [nx2 ny2]]))
                      [#{[0 0]} [0 0] [0 0]]
                      (partition 2 raw-data))]
    (count m)))

#_ (solve "^v")
;; => 3

#_ (solve "^>v<")
;; => 3

#_ (solve "^v^v^v^v^v")
;; => 11

#_ (solve d/raw-data)
;; => 2360
