(ns advent-of-code.2015.day1-2
  (:require [advent-of-code.2015.day1-1 :as d11]))

(defn solve [data]
  (reduce (fn [[floor pos] p]
            (let [floor (case p
                          \( (inc floor)
                          \) (dec floor))]
              (if (= -1 floor)
                (reduced pos)
                [floor (inc pos)])))
          [0 1]
          data))

#_ (solve ")")
;; => 1

#_ (solve "()())")
;; => 5

#_ (solve d11/data)
;; => 1783
