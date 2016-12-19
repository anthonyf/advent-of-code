(ns advent-of-code.2016.day-04.2
  (:require [advent-of-code.2016.day-04-1 :as day4-1]))

(defn rotate-char
  [c]
  (case c
    \space c
    \- \space
    (char (+ (mod (- (+ (int c) 1)
                     (int \a))
                  26)
             (int \a)))))

#_ (rotate-char \-)
;; => \space
#_ (rotate-char \a)
;; => \b
#_ (rotate-char \z)
;; => \a

(defn shift-name
  [name]
  (apply str (map rotate-char
                  name)))

#_ (shift-name "ab-vz")
;; => "bc wa"

(defn decrypt-room
  [{:keys [name sector-id _] :as line}]
  (assoc line :decrypted (reduce (fn [name _]
                                   (shift-name name))
                                 name
                                 (range sector-id))))

#_ (decrypt-room (day4-1/parse-line "qzmt-zixmtkozy-ivhz-343[asdsf]"))
;; => {:name "qzmt-zixmtkozy-ivhz-", :sector-id 343, :checksum "asdsf", :decrypted "very encrypted name "}


(defn solve []
  (reduce (fn [answer {:keys [decrypted sector-id]}]
            (if (= decrypted "northpole object storage ")
              (reduced sector-id)
              nil))
          nil
          (map decrypt-room
               (reduce (fn [valid {:keys [name sector-id checksum] :as line}]
                         (if (day4-1/valid-checksum? line)
                           (conj valid line)
                           valid))
                       []
                       (day4-1/parse-data day4-1/raw-data)))))

#_ (solve)
;; => 501
