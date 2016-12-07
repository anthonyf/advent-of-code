(ns advent-of-code.2016.day7-1
  (:require [advent-of-code.utils :as u]
            [advent-of-code.2016.day7-data :as d]
            [clojure.string :as str]
            [clojure.set :as set]))

(defn parse-line
  [line]
  (let [non-hyper (set (str/split line
                                  #"\[[a-z]*\]"))]
    [non-hyper
     (set/difference (set (str/split line
                                     #"[\[\]]"))
                     non-hyper)]))

#_ (parse-line "xdsqxnovprgovwzkus[fmadbfsbqwzzrzrgdg]aeqornszgvbizdm")

#_ (parse-line "itgslvpxoqqakli[arktzcssgkxktejbno]wsgkbwwtbmfnddt[zblrboqsvezcgfmfvcz]iwyhyatqetsreeyhh")

(defn maplist [f col]
  (loop [acc []
         col col]
    (if (empty? col)
      acc
      (do (f col)
          (recur (conj acc col)
                 (drop 1 col))))))

(defn abba?
  [s]
  (reduce (fn [abba? [a b c d & _]]
            (if (and (= a d)
                     (= b c)
                     (not= a b))
              (reduced true)
              false))
          false
          (maplist identity s)))

#_ (abba? "abba")
;; => true

#_ (abba? "asdfxyyxasdf")
;; => true

(defn tls?
  [non-hyper hyper]
  (true? (and (some abba? non-hyper)
              (not-any? abba? hyper))))

#_ (apply tls? (parse-line "xdsqxnovprgovwzkus[fmadbfsbqwzzrzrgdg]aeqornszgvbizdm"))
;; => false

#_ (apply tls? (parse-line "abba[mnop]qrst")) ;;supports TLS (abba outside square brackets).
;; => true
#_ (apply tls? (parse-line "abcd[bddb]xyyx")) ;;does not support TLS (bddb is within square brackets, even though xyyx is outside square brackets).
;; => false
#_ (apply tls? (parse-line "aaaa[qwer]tyui")) ;; does not support TLS (aaaa is invalid; the interior characters must be different).
;; => false
#_ (apply tls? (parse-line "ioxxoj[asdfgh]zxcvbn")) ;;supports TLS (oxxo is outside square brackets, even though it's within a larger string).
;; => true

(defn solve
  []
  (reduce (fn [sum line]
            (if (apply tls? (parse-line line))
              (inc sum)
              sum))
          0
          (str/split-lines d/raw-data)))

#_ (solve);; => 115
