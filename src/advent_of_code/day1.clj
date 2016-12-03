(ns advent-of-code.day1
  (:require [clojure.string :as str]))

(def instructions (map (fn [instruction]
                         (let [instruction (str instruction)]
                           [(case (first instruction)
                              \L :left
                              \R :right)
                            (Integer/parseInt (subs instruction 1))]))
                       #_ '[R2 L3]
                       #_ '[R2, R2, R2]
                       #_ '[R5, L5, R5, R3]
                       '[L5, R1, L5, L1, R5, R1, R1, L4, L1, L3, R2, R4, L4, L1, L1, R2, R4, R3, L1, R4, L4, L5, L4, R4, L5, R1, R5, L2, R1, R3, L2, L4, L4, R1, L192, R5, R1, R4, L5, L4, R5, L1, L1, R48, R5, R5, L2, R4, R4, R1, R3, L1, L4, L5, R1, L4, L2, L5, R5, L2, R74, R4, L1, R188, R5, L4, L2, R5, R2, L4, R4, R3, R3, R2, R1, L3, L2, L5, L5, L2, L1, R1, R5, R4, L3, R5, L1, L3, R4, L1, L3, L2, R1, R3, R2, R5, L3, L1, L1, R5, L4, L5, R5, R2, L5, R2, L1, L5, L3, L5, L5, L1, R1, L4, L3, L1, R2, R5, L1, L3, R4, R5, L4, L1, R5, L1, R5, R5, R5, R2, R1, R2, L5, L5, L5, R4, L5, L4, L4, R5, L2, R1, R5, L1, L5, R4, L3, R4, L2, R3, R3, R3, L2, L2, L2, L1, L4, R3, L4, L2, R2, R5, L1, R2]))

(def new-facing {:north {:left :west
                         :right :east}
                 :south {:left :east
                         :right :west}
                 :west {:left :south
                        :right :north}
                 :east {:left :north
                        :right :south}})

(defn step
  [{facing :facing [x y] :pos} [dir spaces]]
  (let [facing (-> new-facing facing dir)
        pos (case facing
              :north [x (+ y spaces)]
              :east [(+ x spaces) y]
              :south [x (- y spaces)]
              :west [(- x spaces) y])]
    {:facing facing :pos pos}))

(defn solve []
  (let [{[x y] :pos} (reduce step
                             {:facing :north :pos [0 0]}
                             instructions)]
    (+ (Math/abs x)
       (Math/abs y))))

#_ (solve)
