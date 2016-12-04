(ns advent-of-code.day2.2
  (:require [advent-of-code.day2.1 :as d2.1]))

(def keypad '[[_ _ 1 _ _]
              [_ 2 3 4 _]
              [5 6 7 8 9]
              [_ A B C _]
              [_ _ D _ _]])

(defn move [[x y] input]
  (let [[nx ny] (case input
                  \U [x (- y 1)]
                  \L [(- x 1) y]
                  \D [x (+ y 1)]
                  \R [(+ x 1) y])]
    (if (and (>= nx 0) (>= ny 0)
             (< nx 5) (< ny 5)
             (not= '_ (get-in keypad [ny nx])))
      [nx ny]
      [x y])))

#_ (move [0 2] \U)

(defn key [[[x y] keys] input]
  (let [[x y] (reduce move
                      [x y]
                      input)]
    [[x y] (conj keys (get-in keypad [y x]))]))

#_ (key [[0 2] []] (vec "R"))
#_ (key [[0 2] []] (vec "ULL"))

(defn solve []
  (second (reduce key
                  [[0 2] []]
                  d2.1/input)))

#_ (solve)
