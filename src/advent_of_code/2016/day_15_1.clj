(ns advent-of-code.2016.day-15-1
  (:require [clojure.string :as str]))

(def sample-data "Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.")

(def data "Disc #1 has 7 positions; at time=0, it is at position 0.
Disc #2 has 13 positions; at time=0, it is at position 0.
Disc #3 has 3 positions; at time=0, it is at position 2.
Disc #4 has 5 positions; at time=0, it is at position 2.
Disc #5 has 17 positions; at time=0, it is at position 0.
Disc #6 has 19 positions; at time=0, it is at position 7.")

(def reg-ex #"Disc #(\d+) has (\d+) positions; at time=(\d+), it is at position (\d+).")

(defn parse-discs
  [s]
  (->> s
       str/split-lines
       (map (fn [line]
              (let [[_ & fields] (re-matches reg-ex line)
                    [disc positions time position] (map #(Integer/parseInt %) fields)]
                {:disc disc
                 :positions positions
                 :time time
                 :position position})))))

#_ (parse-discs sample-data)
;; => ({:disc 1, :positions 5, :time 0, :position 4} {:disc 2, :positions 2, :time 0, :position 1})

#_ (parse-discs data)
;; => ({:disc 1, :positions 7, :time 0, :position 0} {:disc 2, :positions 13, :time 0, :position 0} {:disc 3, :positions 3, :time 0, :position 2} {:disc 4, :positions 5, :time 0, :position 2} {:disc 5, :positions 17, :time 0, :position 0} {:disc 6, :positions 19, :time 0, :position 7})

(advance-disc {:disc 1, :positions 5, :time 0, :position 4} 1)

(defn drop
  [discs t]
  (reduce (fn [_ [i disc]]
            (let [t (+ t i 1)
                  {:keys [position]} (advance-disc disc t)]
              (if (zero? position)
                true
                (reduced false))))
          true
          (map-indexed vector discs)))

#_ (drop (parse-discs sample-data) 5)

(defn find-time
  [discs]
  (reduce (fn [_ t]
            (if (drop discs t)
              (reduced t)
              nil))
          nil
          (range)))

(defn solve
  []
  (-> data
      parse-discs
      find-time))

#_ (solve)
;; => 121834
