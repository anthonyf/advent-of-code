(ns advent-of-code.2016.day-19-1
  (:require [clojure.data.finger-tree :as ft]))

(defn step
  [circle]
  (conj (rest (rest circle))
        (first circle)))

#_ (-> (apply ft/counted-double-list (range 1 (inc 5)))
       step
       step
       step
       step)
;; => (3)

(defn exchange-presents
  [number-of-elves]
  (loop [elves (apply ft/counted-double-list (range 1 (inc number-of-elves)))]
    (if (= (count elves) 1)
      (first elves)
      (recur (step elves)))))

#_ (exchange-presents 5) ;; => 3

(defn solve
  []
  (exchange-presents 3014387))

#_ (solve)
;; => 1834471
