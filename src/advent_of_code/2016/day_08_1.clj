(ns advent-of-code.2016.day-08-1
  (:require [advent-of-code.2016.day-08-data :as d]
            [clojure.string :as str]))

(defn parse-command
  [line]
  (if-let [[_ c a b] (or (re-matches #"(rect) ([0-9]+)x([0-9]+)" line)
                         (re-matches #"(rotate row) y=([0-9]+) by ([0-9]+)" line)
                         (re-matches #"(rotate column) x=([0-9]+) by ([0-9]+)" line))]
    [(case c
       "rect" :rect
       "rotate row" :rotate-row
       "rotate column" :rotate-column)
     (Integer/parseInt a)
     (Integer/parseInt b)]))

#_ (parse-command "rect 10x1")
;; => [:rect 10 1]
#_ (parse-command "rotate row y=0 by 10")
;; => [:rotate-row 0 10]
#_ (parse-command "rotate column x=0 by 10")
;; => [:rotate-column 0 10]

(defn rect
  [board w h]
  (reduce (fn [board x]
            (reduce (fn [board y]
                      (assoc board [(mod x 50)
                                    (mod y 6)] :#))
                    board
                    (range h)))
          board
          (range w)))

#_ (rect {} 3 2)
;; => {[0 0] :#, [0 1] :#, [1 0] :#, [1 1] :#, [2 0] :#, [2 1] :#}


(defn print-board
  [board]
  (dotimes [y 6]
    (dotimes [x 50]
      (print (case (board [x y])
               :# "#"
               ".")))
    (println)))

#_ (print-board (rect {} 3 2))

(defn rotate
  [row n]
  (vec (reduce (fn [row _]
                 (concat [(last row)]
                         (take (- (count row) 1) row)))
               row
               (range n))))

#_ (rotate [1 2 3 4] 2)
;; => [3 4 1 2]

(defn rotate-row
  [board y spaces]
  (let [row (map (fn [x]
                   (board [x y]))
                 (range 50))
        row (rotate row spaces)]
    (reduce (fn [board x]
              (assoc board [x y] (row x)))
            board
            (range 50))))

#_ (print-board (rotate-row (rect {} 3 2) 0 51))

(defn rotate-column
  [board x spaces]
  (let [col (map (fn [y]
                   (board [x y]))
                 (range 6))
        col (rotate col spaces)]
    (reduce (fn [board y]
              (assoc board [x y] (col y)))
            board
            (range 6))))

#_ (print-board (rotate-column (rect {} 3 2) 0 7))


(defn solve
  []
  (let [board (reduce (fn [board [command a b]]
                        (case command
                          :rect (rect board a b)
                          :rotate-row (rotate-row board a b)
                          :rotate-column (rotate-column board a b)))
                      {}
                      (map parse-command (str/split-lines d/raw-data)))]
    (print-board board)
    (reduce (fn [sum x]
              (reduce (fn [sum y]
                        (if (= :# (board [x y]))
                          (+ sum 1)
                          sum))
                      sum
                      (range 6)))
            0
            (range 50))))

#_ (solve);; => 121
;; ###..#..#.###..#..#..##..####..##..####..###.#....
;; #..#.#..#.#..#.#..#.#..#.#....#..#.#......#..#....
;; #..#.#..#.#..#.#..#.#....###..#..#.###....#..#....
;; ###..#..#.###..#..#.#....#....#..#.#......#..#....
;; #.#..#..#.#.#..#..#.#..#.#....#..#.#......#..#....
;; #..#..##..#..#..##...##..####..##..####..###.####.
;; RURUCEOEIL
