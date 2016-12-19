(ns advent-of-code.2016.day-16-1
  (:require [clojure.string :as str]))

(defn dragon
  [a]
  (let [b (->> a
               reverse
               (map (fn [d] (case d
                              \0 \1
                              \1 \0))))]
    (str a 0 (str/join b))))

#_ (dragon "1")
;; => "100"

#_ (dragon "0")
;; => "001"

#_ (dragon "11111")
;; => "11111000000"

#_ (dragon "111100001010")
;; => "1111000010100101011110000"

(defn fill-disk
  [a length]
  (loop [a a]
    (let [a-len (count a)]
      (if (>= a-len length)
        (subs a 0 length)
        (recur (dragon a))))))

#_ (fill-disk "10000" 20)
;; => "10000011110010000111"

(defn checksum
  [a]
  (loop [a a]
    (let [a (->> a
                 (partition 2)
                 (map (fn [[a b]]
                        (if (= a b) \1 \0)))
                 str/join)]
      (if (odd? (count a))
        a
        (recur a)))))

#_ (checksum "10000011110010000111")
;; => "01100"

(defn solve
  []
  (checksum (fill-disk "00101000101111010" 272)))

#_ (solve)
;; => "10010100110011100"
