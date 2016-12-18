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

(defn traps
  [s total-rows]
  (reduce (fn [rows row-index]
            (conj rows
                  (reduce (fn [row i]
                            (assoc row i (trap (rows (dec row-index))
                                               i)))
                          (vec (repeat (count s) \.))
                          (range (count s)))))
          [(vec s)]
          (range 1 total-rows)))

(defn count-safe
  [s total-rows]
  (let [traps (traps s total-rows)]
    (reduce (fn [sum c]
              (+ sum (case c
                       \. 1
                       \^ 0)))
            0
            (flatten traps))))

(defn solve
  []
  (let [s #_ "..^^."
        #_ ".^^.^.^^^^"
        data
        total-rows #_ 3 #_ 10 40]
    (count-safe s total-rows)))

#_ (solve)
;; => 1961
