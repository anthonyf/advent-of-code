(ns advent-of-code.2016.day-19-1)

(defn step
  [circle]
  (conj (subvec circle 2)
        (first circle)))

#_ (-> [1 2 3 4 5]
       step
       step
       step
       step)
;; => (3)

(defn exchange-presents
  [number-of-elves step-fn]
  (loop [elves (vec (range 1 (inc number-of-elves)))]
    (if (= (count elves) 1)
      (first elves)
      (recur (step-fn elves)))))

#_ (exchange-presents 5) ;; => 3

(defn solve
  []
  (exchange-presents 3014387 step))

#_ (solve)
;; => 1834471
