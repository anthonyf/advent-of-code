(ns advent-of-code.2016.day-05-2
  (:require [advent-of-code.2016.day5-1 :as d51]))

(defn seventh-digit
  [s]
  (subs s 6 7))

(defn find-digit
  [input start visited-digits]
  (loop [i start]
    (let [m (d51/md5sum (str input i))
          valid-hash? (d51/five-zeros-hash? m)
          place (Integer/parseInt (d51/sixth-digit m) 16)]
      (if (and valid-hash?
               (< place 8)
               (not (contains? visited-digits place)))
        [place
         (seventh-digit m)
         (inc i)
         (conj visited-digits place)]
        (recur (inc i))))))

#_ (find-digit "abc" 0)
;; => ["1" "5" 3231930]

(defn solve
  [input]
  (apply str
         (first
          (reduce (fn [[answer start visited-digits] _]
                    (let [[place digit n visited-digits] (find-digit input start visited-digits)]
                      [(assoc answer place digit)
                       n
                       visited-digits]))
                  [(vec (replicate 8 nil)) 0 #{}]
                  (range 8)))))

#_ (solve "abc")
;; => "05ACE8E3"

#_ (solve "cxdnnyjw")
;; => "999828EC"
