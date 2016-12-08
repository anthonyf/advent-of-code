(ns advent-of-code.2016.day7-2
  (:require [advent-of-code.utils :as u]
            [advent-of-code.2016.day7-data :as d]
            [advent-of-code.2016.day7-1-data :as d7]))


(defn aba-acc
  [acc [a b c & _]]
  (if (and (= a c)
           (not= a b))
    (conj acc [a b c])
    acc))

(defn proto?
  [s acc-fn]
  (set (reduce acc-fn
               []
               (u/maplist identity s))))

(defn aba? [s] (proto? s aba-acc))

#_ (aba? "asdfabaaaacadadad")
;; => #{[\a \b \a] [\a \d \a] [\a \c \a] [\d \a \d]}

(defn bab?
  [s [a b c :as aba]]
  (let [bab (aba? s)]))
