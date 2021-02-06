
# Pieces from https://github.com/brandonchartier/janet-html

(def- void-elements
  [:area :base :br :col :embed
   :hr :img :input :keygen :link
   :meta :param :source :track :wbr])

(defn- void-element? [name]
  (some (partial = name) void-elements))

(defn- attr-reducer [acc [attr value]]
  (string acc " " attr "=\"" value "\""))

(defn- create-attrs [attrs]
  (reduce attr-reducer "" (pairs attrs)))

(defn- opening-tag [name attrs]
  (string "<" name (create-attrs attrs) ">"))

(defn- closing-tag [name]
  (string "</" name ">"))

(defn- create-element [name attrs & children]
  (assert (keyword? name) "expected keyword for name")
  (assert (struct? attrs) "expected struct for attrs")

  (defn reducer [acc element]
    (if (tuple? element)
      (string acc (create-element ;element))
      (string acc element)))

  (if (void-element? name)
    (opening-tag name attrs)
    (string (opening-tag name attrs)
            (reduce reducer "" children)
            (closing-tag name))))

(defn encode [element]
  (create-element ;element))

(defmacro each [x ds & body]
  ~(splice (map (fn [item] (let [,x item] ,;body)) ,ds)))
