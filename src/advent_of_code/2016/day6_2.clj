(ns advent-of-code.2016.day6-2
  (:require [advent-of-code.2016.day6-1 :as d6]
            [advent-of-code.2016.day6-data :as d]))

(defn most-freq-for-column
  [pos-letter-freqs pos]
  (let [[[letter freq] & _] (sort-by second (get pos-letter-freqs pos))]
    letter))

(defn solve [raw-data]
  (let [pos-letter-freqs (d6/pos-letter-freqs raw-data)
        num-letters (count pos-letter-freqs)]
    (apply str (map (fn [n]
                      (most-freq-for-column pos-letter-freqs n))
                    (range num-letters)))))

#_ (solve d/sample-data)
;; => "advent"

#_ (solve d/raw-data)
;; => "xrwcsnps"
