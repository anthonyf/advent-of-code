(ns advent-of-code.2016.day-19-2
  (:require [advent-of-code.2016.day-19-1 :as p1]))

(defn step
  [elves]
  (let [mid (/ (count elves) 2)]
    (vec
     (concat (subvec elves 1 mid)
             (subvec elves (inc mid))
             (subvec elves 0 1)))))

#_ (-> [1 2 3 4 5]
       step
       step
       step
       step)

(defn exchange-presents
  "Run around the elves in a circle starting at the middle and drop-drop-skip
  until there is only one elf left."
  [n]
  (let [elves (vec (range 1 (inc n)))
        mid (int (/ (count elves) 2))
        actions (if (even? (count elves))
                  [:drop :drop :skip]
                  [:drop :skip :drop])]
    (loop [elves elves
           i mid
           n n
           action-i 0]
      (if (nil? (elves i))
        ;; skip over eliminated
        (recur elves
               (mod (inc i) (count elves))
               n
               action-i)
        (if (= 1 n)
          ;; done
          (elves i)
          ;; perform next drop or skip action
          (let [action (actions (mod action-i 3))]
            (case action
              :drop (recur (assoc elves i nil)
                           (mod (inc i) (count elves))
                           (dec n)
                           (mod (inc action-i) 3))
              :skip (recur elves
                           (mod (inc i) (count elves))
                           n
                           (mod (inc action-i) 3)))))))))

#_ (exchange-presents 7)
;; => 1

(p1/exchange-presents 7 step)

#_ (doseq [n (range 4 20)]
     (println (exchange-presents n) (p1/exchange-presents n step)))

(defn solve
  []
  (exchange-presents 3014387))

#_ (solve)
;; => 1420064
