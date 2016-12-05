(ns advent-of-code.2016.day1-2
  (:require [advent-of-code.2016.day1-1 :as d1]))

(defn explode-instruction
  [[facing spaces :as inst]]
  (if (> spaces 1)
    (concat [[facing 1]]
            (map (fn [n]
                   [:forward 1])
                 (range (dec spaces))))
    [inst]))

#_ (explode-instruction [:left 4])
;; => ([:left 1] [:forward 1] [:forward 1] [:forward 1])

(def instructions (mapcat explode-instruction
                          d1/instructions))

(def new-facing {:north {:left :west
                         :right :east
                         :forward :north}
                 :south {:left :east
                         :right :west
                         :forward :south}
                 :west {:left :south
                        :right :north
                        :forward :west}
                 :east {:left :north
                        :right :south
                        :forward :east}})

(defn step
  [{facing :facing [x y] :pos} [dir spaces]]
  (let [facing (-> new-facing facing dir)
        pos (case facing
              :north [x (+ y spaces)]
              :east [(+ x spaces) y]
              :south [x (- y spaces)]
              :west [(- x spaces) y])]
    {:facing facing :pos pos}))

(defn solve
  []
  (let [{[x y] :pos} (reduce (fn [[visited result] instruction]
                               (let [{pos :pos :as result} (step result instruction)]
                                 (if (contains? visited pos)
                                   (reduced {:pos pos})
                                   [(conj visited pos) result])))
                             [#{} {:facing :north :pos [0 0]}]
                             instructions)]
    (+ (Math/abs x)
       (Math/abs y))))

#_ (solve)
;; => 79
