(ns advent-of-code.2016.day-21-2
  (:require [advent-of-code.2016.day-21-data :as d]
            [advent-of-code.2016.day-21-1 :as p1]
            [clojure.string :as str]))

(defn unswap-positions
  [password x y]
  (p1/swap-positions password y x))

(defn unswap-letters
  [password x y]
  (p1/swap-letters password y x))

(defn unrotate
  [password direction steps]
  (p1/rotate password (case direction :left :right :right :left) steps))

(defn rev-index
  [password]
  (reduce (fn [result letter]
            (let [x (.indexOf password letter)
                  num-rots (inc (if (>= x 4) (inc x) x))]
              (assoc result (mod (+ x num-rots)
                                 (count password))
                     num-rots)))
          (vec (repeat (count password) 0))
          password))

#_ (rev-index (vec "abcdefgh"))
;; => [9 1 6 2 7 3 8 4]

(defn unrotate-letter
  [password letter]
  (let [rev-index (rev-index password)
        x (.indexOf password letter)
        x (rev-index x)]
    (p1/rotate password :left x)))


(defn unreverse-positions
  [password x y]
  (p1/reverse-positions password x y))

(defn unmove-position
  [password x y]
  (p1/move-position password y x))

(def unscramble-fns {p1/swap-positions    unswap-positions
                     p1/swap-letters      unswap-letters
                     p1/rotate            unrotate
                     p1/rotate-letter     unrotate-letter
                     p1/reverse-positions unreverse-positions
                     p1/move-position     unmove-position})

(defn unscramble-line
  [password line]
  (reduce (fn [password [regex scramble-fn arg-convs]]
            (if-let [args (re-matches regex line)]
              (let [password (apply (unscramble-fns scramble-fn) password
                                    (map (fn [arg arg-conv]
                                           (arg-conv arg))
                                         (rest args)
                                         arg-convs))]
                (println password)
                (reduced password))
              password))
          password
          p1/scramble-dispatch-table))

(defn unscramble
  [password line-scrambler-fn input]
  (apply str
         (reduce line-scrambler-fn
                 (vec password)
                 (reverse (str/split-lines input)))))

#_ (unscramble "decab" unscramble-line d/test-input)

(defn solve
  []
  (unscramble "fbgdceah" unscramble-line d/puzzle-input))

#_ (solve);; => "afhdbegc"
