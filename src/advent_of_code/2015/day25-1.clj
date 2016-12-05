(ns advent-of-code.2015.day25-1)

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
#_ (.indexOf (indexes)
             [2978 3083])
;; => 18361852

(defn code
  [n]
  (loop [i 1
         code 20151125]
    (if (= n i)
      code
      (recur (inc i)
             (rem (* code 252533)
                  33554393)))))

#_ (code 1) ;; => 20151125
#_ (code 2) ;; => 31916031
#_ (code 3) ;; => 18749137

(defn solve [row col]
  (code
   (inc (.indexOf (indexes)
                  [row col]))))


#_ (solve 2 1)
;; => 31916031

#_ (solve 6 4)
;; => 24659492

#_ (solve 6 6)
;; => 27995004

;; To continue, please consult the code grid in the manual.  Enter the code at
;; row 2978, column 3083.
#_ (solve 2978 3083)
;; => 2650453
