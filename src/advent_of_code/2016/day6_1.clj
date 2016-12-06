(ns advent-of-code.2016.day6-1
  (:require [advent-of-code.utils :as u]
            [advent-of-code.2016.day6-data :as d]))

(defn collect-letter
  [letters pos letter]
  (assoc-in letters [pos letter]
            (inc (get-in letters [pos letter] 0))))

#_ (collect-letter {1 {\h 22}} 1 \h)
;; => {1 {\h 23}}

(defn collect-letters
  [letters line]
  (reduce (fn [letters [pos letter]]
            (collect-letter letters pos letter))
          letters
          (map-indexed vector line)))

#_ (collect-letters {} "hello")
;; => {0 {\h 1}, 1 {\e 1}, 2 {\l 1}, 3 {\l 1}, 4 {\o 1}}



#_ (map (fn [[k v]]
          (println k v))
        (reduce collect-letters
                {}
                (u/string-line-seq d/raw-data)))
