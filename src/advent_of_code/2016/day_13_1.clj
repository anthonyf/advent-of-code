(ns advent-of-code.2016.day-13-1
  (:require [clojure.string :as str]))


(defn number-of-1-bits
  [n]
  (loop [bits 0
         n n]
    (if (zero? n)
      bits
      (recur (inc bits)
             (bit-and n (dec n))))))

#_ (number-of-1-bits (Integer/parseInt "1010111" 2))
;; => 5

(defn open-space?
  [[x y] fav]
  (-> (+ (* x x)
         (* 3 x)
         (* 2 x y)
         y
         (* y y)
         fav)
      number-of-1-bits
      even?))

(def open-space-memo? (memoize open-space?))

#_ (open-space? [1 0] 10)

#_ (str/split-lines
    (with-out-str
      (let [fav 10]
        (dotimes [y 7]
          (dotimes [x 10]
            (print (if (open-space? [x y] fav)
                     \.
                     \#)))
          (println)))))
;; => [".#.####.##"
;;     "..#..#...#"
;;     "#....##..."
;;     "###.#.###."
;;     ".##..#..#."
;;     "..##....#."
;;     "#...##.###"]

(defn valid-moves
  [[x y] fav visited]
  (->> [[0 1] [1 0] [-1 0] [0 -1]]
       (map (fn [[ox oy]]
              [(+ x ox)(+ y oy)]))
       (filter (fn [[x y]]
                 (and (>= x 0)
                      (>= y 0))))
       (filter #(open-space-memo? % fav))
       (filter #(not (contains? visited %)))))

#_ (valid-moves [0 0] 10 #{})
;; => ([0 1])

#_ (valid-moves [3 2] 10 #{[4 2]})
;; => ([3 3] [2 2] [3 1])

(defn shortest-path-steps
  [fav end-pos]
  (let [start-pos [1 1]]
    (loop [queue (-> (clojure.lang.PersistentQueue/EMPTY)
                     (conj [#{} start-pos]))]
      (if (empty? queue)
        nil ;; found nothing
        (let [[visited pos] (peek queue)
              queue (pop queue)]
          (if (= pos end-pos)
            (count visited) ;; found shortest path
            (recur (let [visited (conj visited pos)]
                     (reduce (fn [queue move]
                               (conj queue [visited move]))
                             queue
                             (valid-moves pos fav visited))))))))))

#_ (shortest-path-steps 10 [7 4])
;; => 11

(defn solve
  []
  (shortest-path-steps 1352 [31 39]))

#_ (solve)
;; => 90
