(ns advent-of-code.2015.day25.1)

;;    | 1   2   3   4   5   6
;; ---+---+---+---+---+---+---+
;;  1 |  1   3   6  10  15  21
;;  2 |  2   5   9  14  20
;;  3 |  4   8  13  19
;;  4 |  7  12  18
;;  5 | 11  17
;;  6 | 16

(defn indexes []
  (map (fn [a b] [a b])
       (mapcat (fn [n]
                 (range (- n 1) 0 -1))
               (iterate inc 1))
       (mapcat (fn [n]
                 (range 1 n))
               (iterate inc 1))))

#_ (take 10 (indexes))
;; => ([1 1] [2 1] [1 2] [3 1] [2 2] [1 3] [4 1] [3 2] [2 3] [1 4])

#_ (inc (.indexOf (indexes) [1 1]))
;; => 1
#_ (inc (.indexOf (indexes) [14 30]))
;; => 933
