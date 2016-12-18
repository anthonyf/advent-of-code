(ns advent-of-code.2016.day18-1)

(def data "^^.^..^.....^..^..^^...^^.^....^^^.^.^^....^.^^^...^^^^.^^^^.^..^^^^.^^.^.^.^.^.^^...^^..^^^..^.^^^^")

(defn trap
  [prev-row i]
  (let [left? (= \^ (let [i (dec i)]
            (if (< i 0)
              \.
              (prev-row i))))
        center? (= \^ (prev-row i))
        right? (= \^ (let [i (inc i)]
                       (if (>= i (count prev-row))
                         \.
                         (prev-row i))))]
    (if (or (and left? center?
                 (not right?))
            (and right? center?
                 (not left?))
            (and left? (not (or right? center?)))
            (and right? (not (or left? center?))))
      \^
      \.)))

#_ (prev-row-traps (vec "..^^.") 4)

(defn row-safe-count
  [row]
  (reduce (fn [sum c]
            (+ sum (case c
                     \. 1
                     \^ 0)))
          0
          row))

#_ (row-safe-count "..^^.")
;; => 3

(defn safe-traps
  [s total-rows]
  (first
   (reduce (fn [[safe-count prev-row] row-index]
             (let [row (reduce (fn [row i]
                                 (assoc row i (trap prev-row
                                                    i)))
                               (vec (repeat (count s) \.))
                               (range (count s)))]
               [(+ safe-count (row-safe-count row))
                row]))
           [(row-safe-count s) (vec s)]
           (range 1 total-rows))))


#_ (safe-traps "..^^." 3)
;; => 6
#_ (safe-traps ".^^.^.^^^^" 10)
;; => 38

(defn solve
  []
  (safe-traps data 40))

#_ (solve)
;; => 1961
