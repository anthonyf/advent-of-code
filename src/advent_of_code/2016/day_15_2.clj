(ns advent-of-code.2016.day-15-2
  (:require [advent-of-code.2016.day-15-1 :as d1]))

(def data (conj (vec (d1/parse-data d1/data))
                {:disc 7, :positions 11, :time 0, :position 0}))

#_ (identity data)
;; => [{:disc 1, :positions 7, :time 0, :position 0} {:disc 2, :positions 13, :time 0, :position 0} {:disc 3, :positions 3, :time 0, :position 2} {:disc 4, :positions 5, :time 0, :position 2} {:disc 5, :positions 17, :time 0, :position 0} {:disc 6, :positions 19, :time 0, :position 7} {:disc 7, :positions 11, :time 0, :position 0}]

(defn solve
  []
  (-> data
      d1/find-time))

#_ (solve)
;; => 3208099
