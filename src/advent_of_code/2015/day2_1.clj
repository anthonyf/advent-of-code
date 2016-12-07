(ns advent-of-code.2015.day2-1
  (:require [advent-of-code.2015.day2-data :as d]
            [clojure.string :as str]))

#_ (re-matches #" *(\d+)x(\d+)x(\d+)" "22x29x19")
;; => ["22x29x19" "22" "29" "19"]

(defn parse-line
  [line]
  (let [[_ l w h] (re-matches #" *(\d+)x(\d+)x(\d+)" line)]
    [(Integer/parseInt l)
     (Integer/parseInt w)
     (Integer/parseInt h)]))

#_ (parse-line "  22x29x19")
;; => [22 29 19]

(defn paper
  [l w h]
  (let [lw (* l w)
        wh (* w h)
        hl (* h l)]
    (+ (* 2 lw)
       (* 2 wh)
       (* 2 hl)
       (min lw wh hl))))

#_ (paper 2 3 4)
;; => 58

#_ (paper 1 1 10)
;; => 43

(def data (map parse-line
               (str/split-lines d/data)))

(defn solve []
  (reduce (fn [sum [l w h]]
            (+ sum (paper l w h)))
          0
          data))

#_ (solve);; => 1598415
