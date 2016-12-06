(ns advent-of-code.2015.day3-1
  (:require [advent-of-code.2015.day3-data :as d]))

(defn solve
  [raw-data]
  (let [[m _] (reduce (fn [[m [x y]] dir]
                        (let [[nx ny] (case dir
                                        \> [(inc x) y]
                                        \^ [x (dec y)]
                                        \< [(dec x) y]
                                        \v [x (inc y)])]
                          [(conj m [nx ny])
                           [nx ny]]))
                      [#{[0 0]} [0 0]]
                      raw-data)]
    (count m)))

#_ (solve ">")
;; => 2

#_ (solve "^>v<")
;; => 4

#_ (solve "^v^v^v^v^v")
;; => 2

#_ (solve d/raw-data)
;; => 2592
