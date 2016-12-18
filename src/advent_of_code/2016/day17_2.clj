(ns advent-of-code.2016.day17-2
  (:require [advent-of-code.2016.day17-1 :as d1]))


(defn longest-path-length
  [passcode]
  (let [start-pos [0 0]
        end-pos [3 3]]
    (loop [stack [[[] [nil start-pos]]]
           longest-path 0]
      (if (empty? stack)
        longest-path ;; done
        (let [[path [dir pos]] (peek stack)
              stack (pop stack)]
          (if (= pos end-pos)
            ;; found path
            (recur stack
                   (max longest-path (count (rest (conj path dir)))))
            ;; not found
            (let [path (conj path dir)]
              (recur (reduce (fn [stack move]
                               (conj stack [path move]))
                             stack
                             (d1/valid-moves pos passcode (rest path)))
                     longest-path))))))))

#_ (longest-path-length "ihgpwlah")
;; => 370

#_ (longest-path-length "kglvqrro")
;; => 492

#_ (longest-path-length "ulqzkmiv")
;; => 830

(defn solve
  []
  (longest-path-length "gdjjyniy"))

#_ (solve)
;; => 578
