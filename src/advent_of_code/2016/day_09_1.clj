(ns advent-of-code.2016.day-09-1
  (:require [advent-of-code.2016.day-09-data :as d]
            [clojure.string :as str]))

(defn decompress
  [s]
  (loop [start-index 0
         s s]
    (let [prefix (subs s 0 start-index)
          s (subs s start-index)]
      (if-let [marker (re-find #"\([0-9]+x[0-9]+\)" s)]
        (let [index  (str/index-of s marker)
              start (subs s 0 index)
              [_ num-chars num-repeat] (re-matches #"\(([0-9]+)x([0-9]+)\)" marker)
              [num-chars num-repeat] (map #(Integer/parseInt %) [num-chars num-repeat])
              mid-start (+ index (count marker))
              mid-end (+ mid-start num-chars)
              mid (subs s mid-start mid-end)
              mid (apply str (repeat num-repeat mid))
              end (subs s mid-end)]
          (recur (+ start-index (count start) (count mid))
                 (str prefix start mid end)))
        (str prefix s)))))

#_ (decompress "A(2x2)BCD(2x2)EFG")
;; => "ABCBCDEFEFG"

#_ (decompress "ADVENT")
;; => "ADVENT"

#_ (decompress "(3x3)XYZ")
;; => "XYZXYZXYZ"

#_ (= 18 (count (decompress "X(8x2)(3x3)ABCY")))

(defn solve
  []
  (count (decompress d/raw-data)))

#_ (solve)
;; => 138735
