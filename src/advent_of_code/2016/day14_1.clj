(ns advent-of-code.2016.day14-1
  (:require [digest :refer [md5]]))

(def salt "abc")

(defn triples
  [s]
  (first
   (reduce (fn [[triples l] c]
             (let [l (if (or (empty? l)
                             (= (first l) c))
                       (conj l c)
                       [c])]
               (if (>= (count l) 3)
                 [(conj triples c) l]
                 [triples l])))
           [#{} []]
           s)))

#_ (triples "asdfwisssaasdf777")
;; => #{\s \7}

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
  [triples i]
  (reduce (fn [_ [i md5]]
            (if (reduce (fn [_ c]
                          (if (five-of-a-kind? md5 c)
                            (reduced true)
                            false))
                        false
                        triples)
              (reduced true)
              false))
          false
          (map (fn [j] [j (md5 (str salt (+ i j)))])
               (range 1000))))

(defn key
  [n]
  (reduce (fn [key [i md5]]
            (let [triples (triples md5)
                  key (if (and (not (empty? triples))
                               (not (next-1000-hashes-has-five-of-a-kind (triples md5)                                                                         (inc i))))
                        (do (println key i md5)
                            (inc key))
                        key)]
              (if (= key n)
                (reduced i)
                key)))
          0
          (map (fn [i] [i (md5 (str salt i))])
               (range))))

#_ (key 64)
