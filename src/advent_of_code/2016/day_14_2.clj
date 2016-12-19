(ns advent-of-code.2016.day-14-2
  (:require [digest :refer [md5]]
            [advent-of-code.2016.day-14-1 :as d1]))

(defn stretch-hash
  [salt i]
  (reduce (fn [s _]
            (md5 s))
          (md5 (str salt i))
          (range 2016)))

#_ (stretch-hash "abc" 0)
;; => "a107ff634856bb300138cac6568c0f24"

(def stretch-hash-memo (memoize stretch-hash))

(defn solve
  []
  (d1/key d1/salt 64 stretch-hash-memo))

#_ (solve)
;; => 22696
