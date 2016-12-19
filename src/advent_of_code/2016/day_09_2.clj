(ns advent-of-code.2016.day-09-2
  (:require [advent-of-code.2016.day-09-data :as d]
            [clojure.string :as str]))

(defn naive-decompress
  [s]
  (loop [length 0
         s s]
    (if-let [marker (re-find #"\([0-9]+x[0-9]+\)" s)]
      (let [index  (str/index-of s marker)
            [_ num-chars num-repeat] (re-matches #"\(([0-9]+)x([0-9]+)\)" marker)
            [num-chars num-repeat] (map #(Integer/parseInt %) [num-chars num-repeat])
            mid-start (+ index (count marker))
            mid-end (+ mid-start num-chars)
            mid (subs s mid-start mid-end)
            mid (apply str (repeat num-repeat mid))
            end (subs s mid-end)]
        (recur (+ length index)
               (str mid end)))
      (+ length (count s)))))


(defn decompress
  [s]
  (if-let [marker (re-find #"\([0-9]+x[0-9]+\)" s)]
    (let [index  (str/index-of s marker)
          [_ num-chars num-repeat] (re-matches #"\(([0-9]+)x([0-9]+)\)" marker)
          [num-chars num-repeat] (map #(Integer/parseInt %) [num-chars num-repeat])
          mid-start (+ index (count marker))
          mid-end (+ mid-start num-chars)
          end (subs s mid-start)]
      (+ index
         (* num-repeat num-chars)
         (- (decompress end)
            num-chars)))
    (count s)))


#_ (decompress "(3x3)XYZA") ;; => 10

#_ (naive-decompress "(3x3)XYZ") ;; => 9
#_ (decompress "(3x3)XYZ") ;; => 9


#_ (naive-decompress "X(8x2)(3x3)ABCY")
;; => 20
#_ (decompress "X(8x2)(3x3)ABCY")
;; => 24

#_ (naive-decompress "(27x12)(20x12)(13x14)(7x10)(1x12)A")
;; => 241920

#_ (decompress "(27x12)(20x12)(13x14)(7x10)(1x12)A")

(defn solve []
  (naive-decompress d/raw-data))

#_ (solve)
