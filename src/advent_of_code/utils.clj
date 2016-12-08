(ns advent-of-code.utils)

(defn maplist [f col]
  (loop [acc []
         col col]
    (if (empty? col)
      acc
      (do (f col)
          (recur (conj acc col)
                 (drop 1 col))))))
