(ns advent-of-code.2016.day-17-1
  (:require [digest :refer [md5]]
            [clojure.string :as str]))

(def vault-size [4 4])

(defn hash-path
  [passcode path]
  (md5 (str passcode (str/join path))))

#_ (hash-path "hijkl" [\U \D])
;; => "ced9fc52441937264674bca3f4ba7588"

(defn open?
  [c]
  (contains? #{\b \c \d \e \f} c))

#_ (open? \4)
;; => false

#_ (open? \c)
;; => true

(defn open-directions
  [passcode path]
  (let [[u d l r & _] (hash-path passcode path)]
    (reduce (fn [dirs [c dir offset]]
              (if (open? c)
                (conj dirs [dir offset])
                dirs))
            []
            [[u \U [0 -1]]
             [d \D [0 1]]
             [l \L [-1 0]]
             [r \R [1 0]]])))

#_ (open-directions "hijkl" [])
;; => [[\U [0 -1]] [\D [0 1]] [\L [-1 0]]]

(defn valid-moves
  [[x y] passcode path]
  (let [[w h] vault-size]
    (->> (open-directions passcode path)
         (reduce (fn [dirs [dir [ox oy]]]
                   (let [[nx ny] [(+ ox x) (+ oy y)]]
                     (if (and (>= nx 0)
                              (< nx w)
                              (>= ny 0)
                              (< ny h))
                       (conj dirs [dir [nx ny]])
                       dirs)))
                 []))))

#_ (valid-moves [0 0] "hijkl" [])
;; => [[\D [0 1]]]

#_ (valid-moves [0 1] "hijkl" [\D])
;; => [[\U [0 0]] [\R [1 1]]]

#_ (valid-moves [1 1] "hijkl" [\D \R])
;; => []

#_ (valid-moves [0 1] "hijkl" [\D \U])
;; => [[\R [1 1]]]

#_ (valid-moves [1 1] "hijkl" [\D \U \R])
;; => []

(defn shortest-path
  [passcode]
  (let [start-pos [0 0]
        end-pos [3 3]
        queue (clojure.lang.PersistentQueue/EMPTY)]
    (loop [queue (conj queue [[] [nil start-pos]])]
      (if (empty? queue)
        nil ;; found nothing
        (let [[path [dir pos]] (peek queue)
              queue (pop queue)]
          (if (= pos end-pos)
            (str/join (rest (conj path dir))) ;; found shortest path
            (let [path (conj path dir)]
              (recur (reduce (fn [queue move]
                               (conj queue [path move]))
                             queue
                             (valid-moves pos passcode (rest path)))))))))))

#_ (shortest-path "ihgpwlah")
;; => "DDRRRD"

#_ (shortest-path "kglvqrro") ;; => "DDUDRLRRUDRD"

#_ (shortest-path "ulqzkmiv") ;; => "DRURDRUDDLLDLUURRDULRLDUUDDDRR"

(defn solve
  []
  (shortest-path "gdjjyniy"))

#_ (solve);; => "DUDDRLRRRD"
