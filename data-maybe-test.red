Red [
    Title:   "Data.Maybe test script"
    Author:  "unchartedworks"
    File: 	 %data-maybe-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-list.red
#include %data-function.red
#include %prelude.red
#include %data-maybe.red

~~~start-file~~~ "data-maybe"

===start-group=== "Just"
--test-- "integer! -> Just integer!"
    y: Just 1
    z: Just 1
    --assert* [y == z]

--test-- "string! -> Just string!"
    y: Just "red" 
    z: Just "red"
    --assert* [y == z]
===end-group===

===start-group=== "Nothing"
--test-- "Nothing 1"
    y: Nothing
    z: Nothing
    --assert* [y == z]

--test-- "Nothing 2"
    y: Nothing
    z: none
    --assert* [y <> z]
===end-group===

===start-group=== "maybe"
--test-- "integer! -> (integer! -> integer!) -> Maybe integer! -> integer! 1"
    y: 4
    z: maybe 0 ([x] -> [x + 3]) Just 1
    --assert* [y == z]

--test-- "integer! -> (integer! -> integer!) -> Maybe integer! -> integer! 2"
    y: 0
    z: maybe 0 ([x] -> [x + 3]) Nothing
    --assert* [y == z]

--test-- "string! -> (integer! -> string!) -> Maybe integer! -> string! 1"
    y: "A"
    z: maybe "B" ([x] -> [to-string to-char (x + to-integer #"A")]) Just 0
    --assert* [y == z]

--test-- "string! -> (integer! -> string!) -> Maybe integer! -> string! 1"
    y: "B"
    z: maybe "B" ([x] -> [to-string to-char (x + to-integer #"A")]) Nothing
    --assert* [y == z]
===end-group===

===start-group=== "isJust"
--test-- "Just integer! -> logic!"
    y: true
    z: isJust Just 3
    --assert* [y == z]

--test-- "Just string! -> logic!"
    y: true
    z: isJust Just "red"
    --assert* [y == z]

--test-- "Nothing -> logic!"
    y: false
    z: isJust Nothing
    --assert* [y == z]

--test-- "Just Nothing -> logic!"
    y: true
    z: isJust Just Nothing
    --assert* [y == z]
===end-group===

===start-group=== "isNothing"
--test-- "Just integer! -> logic!"
    y: false
    z: isNothing Just 3
    --assert* [y == z]

--test-- "Just string! -> logic!"
    y: false
    z: isNothing Just "red"
    --assert* [y == z]

--test-- "Nothing -> logic!"
    y: true
    z: isNothing Nothing
    --assert* [y == z]

--test-- "Just Nothing -> logic!"
    y: false
    z: isNothing Just Nothing
    --assert* [y == z]

===end-group===

===start-group=== "fromJust"
--test-- "Just integer! -> integer!"
    y: 3
    z: fromJust Just 3
    --assert* [y == z]

--test-- "Just string! -> integer!"
    y: "red"
    z: fromJust Just "red"
    --assert* [y == z]

--test-- "Just Nothing -> logic!"
    y: Nothing
    z: fromJust Just Nothing
    --assert* [y == z]
===end-group===

===start-group=== "fromMaybe"
--test-- "integer! -> Maybe integer! -> integer! 1"
    y: 3
    z: fromMaybe 0 Just 3
    --assert* [y == z]

--test-- "integer! -> Maybe integer! -> integer! 2"
    y: 0
    z: fromMaybe 0 Nothing
    --assert* [y == z]

--test-- "Maybe string! -> string! 1"
    y: "red"
    z: fromMaybe "blue" Just "red"
    --assert* [y == z]

--test-- "Maybe string! -> string! 2"
    y: "blue"
    z: fromMaybe "blue" Nothing
    --assert* [y == z]

--test-- "Nothing -> logic!"
    y: true
    z: fromMaybe true Nothing
    --assert* [y == z]

===end-group===

===start-group=== "listToMaybe"
--test-- "[integer!] -> Maybe integer! 1"
    y: Just 1
    z: listToMaybe [1 2 3]
    --assert* [y == z]

--test-- "[integer!] -> Maybe integer! 2"
    y: Nothing
    z: listToMaybe []
    --assert* [y == z]

--test-- "[string!] -> Maybe string! 1"
    y: Just "abc"
    z: listToMaybe ["abc" "def"]
    --assert* [y == z]

--test-- "[string!] -> Maybe string! 2"
    y: Nothing
    z: listToMaybe []
    --assert* [y == z]

--test-- "string! -> Maybe char! 1"
    y: Just #"a"
    z: listToMaybe "abc"
    --assert* [y == z]

--test-- "string! -> Maybe char! 2"
    y: Nothing
    z: listToMaybe ""
    --assert* [y == z]
===end-group===

===start-group=== "catMaybes"
--test-- "[Maybe integer!] -> [integer!] 1"
    ys: [2 3]
    zs: catMaybes [Nothing Just 2 Just 3]
    --assert* [y == z]

--test-- "[Maybe integer!] -> [integer!] 2"
    ys: []
    zs: catMaybes [Nothing Nothing Nothing]
    --assert* [y == z]

--test-- "[Maybe integer!] -> [integer!] 3"
    ys: []
    zs: catMaybes []
    --assert* [y == z]

--test-- "[Maybe string!] -> [string!] 1"
    ys: ["hello" "world"]
    zs: catMaybes [Just "hello" Nothing Just "world"]
    --assert* [y == z]

--test-- "[Maybe string!] -> [string!] 2"
    ys: ["world"]
    zs: catMaybes [Nothing Just "world"]
    --assert* [y == z]

--test-- "[Maybe char!] -> string! 1"
    ys: "abc"
    zs: catMaybes [Nothing Just #"a" Just #"b" Nothing Just #"c"]
    --assert* [y == z]

--test-- "[Maybe char!] -> string! 2"
    ys: "a"
    zs: catMaybes [Nothing Nothing Just #"a"]
    --assert* [y == z]
===end-group===

===start-group=== "mapMaybes"
--test-- "[Maybe integer!] -> [integer!] 1"
     f: [x] -> [either x > 2 [Just x][Nothing]]
    xs: [1 2 3]
    ys: [1 2]
    zs: mapMaybes :f xs
    --assert* [y == z]

--test-- "[Maybe integer!] -> [integer!] 2"
     f: [x] -> [either x > 2 [Just x][Nothing]]
    xs: []
    ys: [1 2]
    zs: mapMaybes :f xs
    --assert* [y == z]

--test-- "[Maybe string!] -> [integer!] 1"
     f: [x] -> [either (length? x) > 2 [Just length? x][Nothing]]
    xs: ["a" "ab" "abc"]
    ys: [3]
    zs: mapMaybes :f xs
    --assert* [y == z]

--test-- "[Maybe string!] -> [integer!] 2"
     f: [x] -> [either (length? x) > 2 [Just length? x][Nothing]]
    xs: ["a" "ab"]
    ys: [3]
    zs: mapMaybes :f xs
    --assert* [y == z]

--test-- "[Maybe string!] -> string"
     f: [x] -> [either ((:not . :empty?) x) [Just last x][Nothing]]
    xs: ["a" "ab" "abc"]
    ys: "abc"
    zs: mapMaybes :f xs
    --assert* [y == z]
===end-group===

===start-group=== ">>="
hit:      [x] -> [Just (x + 8)]
stand:    [x] -> [either x > 21 [Nothing][Just x]]
win:      [x] -> [Just "$1000"]
showtime: [x] -> [Just ("You win " ++ x ++ "!")]

blackjack: [x [object!]] -> [x >>= :hit >>= :hit >>= :stand >>= :win >>= :showtime]

--test-- "Just integer! -> Just string!"
    y: Just "You win $1000!"
    z: blackjack Just 3
    --assert* [y == z]

--test-- "Just integer! -> Nothing"
    y: Nothing
    z: blackjack Just 8
    --assert* [y == z]
===end-group===
~~~end-file~~~