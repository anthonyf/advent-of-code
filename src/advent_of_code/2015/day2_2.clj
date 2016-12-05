(ns advent-of-code.2015.day2-2
  (:require [advent-of-code.2015.day2-1 :as d2]))

(sort [2 4 3])

(defn ribbon
  [l w h]
  (let [[a b _] (sort [l w h])]
    (+ a a b b
       (* l w h))))

#_ (ribbon 2 3 4) ;; => 34

(defn solve []
  (reduce (fn [sum [l w h]]
            (+ sum (ribbon l w h)))
          0
          d2/data))

#_ (solve)
;; => 3812909
