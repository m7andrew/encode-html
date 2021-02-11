
A small [Janet](https://janet-lang.org) library to create HTML strings from Janet data structures. Similar to Clojure's [Hiccup](https://github.com/weavejester/hiccup).

## Install

```
jpm install https://github.com/m7andrew/encode-html
```

## Examples

Simple HTML structure:

```clojure
(import html)

(html/encode 
  [:div {:class "foo"}
    [:a {:href "/some/link"} "Link"]
    [:span {} "Hello"]])
```
```html
<div class="foo">
  <a href="/some/link">Link</a>
  <span>Hello</span>
</div>
```

Loop using `html/each`:

```clojure
(import html)

(def todos 
  ["Write some janet code"
   "Make a sandwich"
   "Find the lost city of Atlantis"])

(html/encode 
  [:ul {}
    (html/each item todos
      [:li {} item])])
```

Loop using `map`:

```clojure
(import html)

(def todos 
  ["Write some janet code"
   "Make a sandwich"
   "Find the lost city of Atlantis"])

(defn todo [item]
  [:li {} item])

(html/encode 
  [:ul {} ;(map todo todos)])
```

Result using either method:

```html
<ul>
  <li>Write some janet code</li>
  <li>Make a sandwich</li>
  <li>Find the lost city of Atlantis</li>
</ul>
```

## Functions

#### Encode

```clojure
(html/encode element)
```

Takes an element and returns an HTML string.

#### Each

```clojure
(html/each x ds & body)
```

Like Janet's [each](https://janetdocs.com/each). Returns the body for each `x` in the data structure `ds`.

## Syntax

Each element has the general form:

```clojure
[tag attributes & children]
```
* `tag` is a keyword for the tag name.
* `attributes` is a struct with keyword keys and string values.
* `children` is a sequence of elements, strings, or other types of data.

Any child that is not another element (tuple) gets converted to a string. So you can do things like insert numbers directly:

```clojure
[:span {} 42]
```
```html
<span>42</span>
```

