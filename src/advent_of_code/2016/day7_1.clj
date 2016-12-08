(ns advent-of-code.2016.day7-1
  (:require [advent-of-code.utils :as u]
            [advent-of-code.2016.day7-data :as d]
            [clojure.string :as str]
            [clojure.set :as set]))

(defn parse-line
  [line]
  (let [supernet (set (str/split line
                                 #"\[[a-z]*\]"))]
    [supernet
     (set/difference (set (str/split line
                                     #"[\[\]]"))
                     supernet)]))

#_ (parse-line "xdsqxnovprgovwzkus[fmadbfsbqwzzrzrgdg]aeqornszgvbizdm")
;; => [#{"aeqornszgvbizdm" "xdsqxnovprgovwzkus"} #{"fmadbfsbqwzzrzrgdg"}]

#_ (parse-line "itgslvpxoqqakli[arktzcssgkxktejbno]wsgkbwwtbmfnddt[zblrboqsvezcgfmfvcz]iwyhyatqetsreeyhh")
;; => [#{"wsgkbwwtbmfnddt" "itgslvpxoqqakli" "iwyhyatqetsreeyhh"} #{"arktzcssgkxktejbno" "zblrboqsvezcgfmfvcz"}]

(defn abba?
  [s]
  (reduce (fn [_ [a b c d & _]]
            (if (and (= a d)
                     (= b c)
                     (not= a b))
              (reduced true)
              false))
          false
          (u/maplist identity s)))

#_ (abba? "abba")
;; => true

#_ (abba? "asdfxyyxasdf")
;; => true

(defn tls?
  [supernet hypernet]
  (true? (and (some abba? supernet)
              (not-any? abba? hypernet))))

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
