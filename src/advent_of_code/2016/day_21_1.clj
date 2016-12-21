(ns advent-of-code.2016.day-21-1
  (:require [advent-of-code.2016.day-21-data :as d]
            [clojure.string :as str]))

(def re-swap-positions #"swap position (\d+) with position (\d+)")
(def re-swap-letters #"swap letter ([a-z]) with letter ([a-z])")
(def re-rotate #"rotate (right|left) (\d+) step(?:|s)")
(def re-rotate-letter #"rotate based on position of letter ([a-z])")
(def re-reverse-positions #"reverse positions (\d+) through (\d+)")
(def re-move-position #"move position (\d+) to position (\d+)")

(defn swap-positions
  [password x y]
  (let [a (get password x)
        b (get password y)]
    (-> password
        (assoc x b)
        (assoc y a))))

#_ (swap-positions (vec "abcd") 2 3)
;; => [\a \b \d \c]

(defn swap-letters
  [password x y]
  (swap-positions password
                  (.indexOf password x)
                  (.indexOf password y)))

#_ (swap-letters (vec "abcd") \a \c)
;; => [\c \b \a \d]

(defn rotate
  [password direction steps]
  (let [steps (mod (case direction :left steps :right (- steps))
                   (count password))]
    (vec (concat (subvec password steps)
                 (subvec password 0 steps)))))

#_ (rotate (vec "abcde") :left 1)
;; => [\b \c \d \e \a]
;; => [\b \c \d \a]

(defn rotate-letter
  [password letter]
  (let [x (.indexOf password letter)
        x (inc (if (>= x 4) (inc x) x))]
    (rotate password :right x)))

#_ (rotate-letter (vec "abdec") \b)
;; => [\e \c \a \b \d]
#_ (rotate-letter (vec "ecabd") \d)
;; => [\d \e \c \a \b]

(defn reverse-positions
  [password x y]
  (vec (concat (subvec password 0 x)
               (reverse (subvec password x (inc y)))
               (subvec password (inc y)))))

#_ (reverse-positions (vec "abcd") 0 3)
;; => [\d \c \b \a]

(defn move-position
  [password x y]
  (let [letter (get password x)
        password (vec (concat (subvec password 0 x)
                              (subvec password (inc x))))]
    (vec (concat (subvec password 0 y)
                 [letter]
                 (subvec password y)))))

#_ (move-position (vec "bcdea") 1 4)
;; => [\b \d \e \a \c]

(def scramble-dispatch-table
  ;; [ regex | scramble-function | argument conversions ]
  [[re-swap-positions    swap-positions    [#(Integer/parseInt %)
                                            #(Integer/parseInt %)]]
   [re-swap-letters      swap-letters      [first first]]
   [re-rotate            rotate            [keyword #(Integer/parseInt %)]]
   [re-rotate-letter     rotate-letter     [first]]
   [re-reverse-positions reverse-positions [#(Integer/parseInt %)
                                            #(Integer/parseInt %)]]
   [re-move-position     move-position     [#(Integer/parseInt %)
                                            #(Integer/parseInt %)]]])

(defn scramble-line
  [password line]
  (reduce (fn [password [regex scramble-fn arg-convs]]
            (if-let [args (re-matches regex line)]
              (reduced
               (apply scramble-fn password
                      (map (fn [arg arg-conv]
                             (arg-conv arg))
                           (rest args)
                           arg-convs)))
              password))
          password
          scramble-dispatch-table))

#_ (scramble-line (vec "abcde") "rotate left 1 step")
;; => [\b \c \d \e \a]
#_ (scramble-line (vec "abcde") "rotate left 2 steps")
;; => [\c \d \e \a \b]

(defn scramble
  [password input]
  (apply str
         (reduce scramble-line
                 (vec password)
                 (str/split-lines input))))

#_ (scramble "abcde" d/test-input)

(defn solve
  []
  (scramble "abcdefgh" d/puzzle-input))

#_ (solve)
;; => "agcebfdh"
