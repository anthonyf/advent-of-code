(ns advent-of-code.2016.day14-1
  (:require [digest :refer [md5]]))

(def salt "ahsbgdzn"
  #_ "abc")

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

(defn next-1000-hashes-has-five-of-a-kind
  [c i]
  (reduce (fn [_ [i md5]]
            (if (five-of-a-kind? md5 c)
              (reduced true)
              false))
          false
          (map (fn [j] [j (md5 (str salt (+ i j)))])
               (range 1000))))

(defn key
  [n]
  (reduce (fn [key [i md5]]
            (let [triple (triple md5)
                  key (if (and (not (nil? triple))
                               (next-1000-hashes-has-five-of-a-kind triple (inc i)))
                        (do (println key i md5)
                            (inc key))
                        key)]
              (if (= key n)
                (reduced i)
                key)))
          0
          (map (fn [i] [i (md5 (str salt i))])
               (range))))

(defn solve []
  (key 64))

#_ (solve)
;; => 23890
