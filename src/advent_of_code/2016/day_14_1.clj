(ns advent-of-code.2016.day-14-1
  (:require [digest :refer [md5]]))

(defn triple
  [s]
  (first
   (reduce (fn [[triple l] c]
             (let [l (if (or (empty? l)
                             (= (first l) c))
                       (conj l c)
                       [c])]
               (if (>= (count l) 3)
                 (reduced [c nil])
                 [triple l])))
           [nil []]
           s)))

#_ (triple "asdfwwwisssaasdf777")
;; => \w

(defn five-of-a-kind?
  [s cc]
  (true?
   (reduce (fn [l c]
             (let [l (if (= c cc)
                       (conj l c)
                       [])]
               (if (>= (count l) 5)
                 (reduced true)
                 l)))
           []
           s)))

#_ (five-of-a-kind? "asssssdfasf" \s)
;; => true

(defn md5-hash
  [salt i]
  (md5 (str salt i)))

(defn next-1000-hashes-has-five-of-a-kind
  [c salt i hash]
  (reduce (fn [_ [i md5]]
            (if (five-of-a-kind? md5 c)
              (reduced true)
              false))
          false
          (map (fn [j] [j (hash salt (+ i j))])
               (range 1000))))

(defn key
  [salt n hash]
  (reduce (fn [key [i md5]]
            (let [triple (triple md5)
                  key (if (and (not (nil? triple))
                               (next-1000-hashes-has-five-of-a-kind triple
                                                                    salt
                                                                    (inc i)
                                                                    hash))
                        (inc key)
                        key)]
              (if (= key n)
                (reduced i)
                key)))
          0
          (map (fn [i] [i (hash salt i)])
               (range))))

(def salt "ahsbgdzn"
  #_ "abc")

(defn solve []
  (key salt 64 md5-hash))

#_ (solve)
;; => 23890
