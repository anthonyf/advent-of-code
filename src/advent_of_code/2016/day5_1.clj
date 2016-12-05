(ns advent-of-code.2016.day5-1
  (:import (java.security MessageDigest)))

(defn md5sum
  [s]
  (let [bytes (.getBytes s)
        md (MessageDigest/getInstance "MD5")
        digest (.digest md bytes)
        bigint (BigInteger. 1, digest)]
    (format "%032X" bigint)))

#_ (md5sum "abc3231929")
;; => "00000155F8105DFF7F56EE10FA9B9ABD"

(defn five-zeros-hash?
  [md5sum]
  (= "00000"
     (subs md5sum 0 5)))

#_ (five-zeros-hash? (md5sum "abc1234"))
;; => false

#_ (five-zeros-hash? (md5sum "abc3231929"))
;; => true

#_ (five-zeros-hash? (md5sum "abc5017308"))
;; => true

(defn sixth-digit
  [s]
  (subs s 5 6))

#_ (sixth-digit (md5sum "abc3231929"))

(defn find-digit
  [input start]
  (loop [i start]
    (let [m (md5sum (str input i))]
      (if (five-zeros-hash? m)
        [(sixth-digit m)
         (inc i)]
        (recur (inc i))))))

#_ (find-digit "abc" 0)

(defn solve
  [input]
  (apply str
         (first
          (reduce (fn [[answer start] _]
                    (let [[digit n] (find-digit input start)]
                      [(conj answer digit)
                       n]))
                  [[] 0]
                  (range 8)))))

#_ (solve "abc")
;; => "18F47A30"

#_ (solve "cxdnnyjw")
;; => "F77A0E6E"
