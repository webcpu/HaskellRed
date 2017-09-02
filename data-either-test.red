Red [
    Title:   "Data.Either test script"
    Author:  "unchartedworks"
    File: 	 %data-either-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %prelude.red
#include %data-list.red
#include %data-function.red
#include %data-either.red

~~~start-file~~~ "data-either"
===start-group=== "Left"
--test-- "integer! -> Either integer! b"
    y: Left 1
    z: Left 1
    --assert* [y == z]

--test-- "string! -> Either string! b"
    y: Left "abc"
    z: Left "abc"
    --assert* [y == z]
===end-group===

===start-group=== "Right"
--test-- "integer! -> Either a integer!"
    y: Right 1
    z: Right 1
    --assert* [y == z]

--test-- "string! -> Either a string!"
    y: Right "abc"
    z: Right "abc"
    --assert* [y == z]
===end-group===

===start-group=== "isLeft"
--test-- "Left integer! b -> logic!"
    y: true
    z: isLeft Left 3
    --assert* [y == z]

--test-- "Left string! b -> logic!"
    y: true
    z: isLeft Left "red"
    --assert* [y == z]

--test-- "Right a integer -> logic!"
    y: false
    z: isLeft Right 3
    --assert* [y == z]

--test-- "Right a string -> logic!"
    y: false
    z: isLeft Right "abc"
    --assert* [y == z]
===end-group===

===start-group=== "isRight"
--test-- "Left integer! b -> logic!"
    y: false
    z: isRight Left 3
    --assert* [y == z]

--test-- "Left string! b -> logic!"
    y: false
    z: isRight Left "red"
    --assert* [y == z]

--test-- "Right a integer! -> logic!"
    y: true
    z: isRight Right 3
    --assert* [y == z]

--test-- "Right a string! -> logic!"
    y: true
    z: isRight Right "abc"
    --assert* [y == z]
===end-group===

===start-group=== "fromLeft"
--test-- "Left integer! b -> integer!"
    y: 3
    z: fromLeft Left 3
    --assert* [y == z]

--test-- "Left string! b -> integer!"
    y: "red"
    z: fromLeft Left "red"
    --assert* [y == z]

--test-- "Right integer! -> logic!"
    y: none
    z: attempt [fromLeft Right 3]
    --assert* [y == z]

--test-- "Right string! -> logic!"
    y: none
    z: attempt [fromLeft Right "abc"]
    --assert* [y == z]
===end-group===

===start-group=== "fromRight"
--test-- "Right integer! b -> integer!"
    y: 3
    z: fromRight Right 3
    --assert* [y == z]

--test-- "Right string! b -> integer!"
    y: "red"
    z: fromRight Right "red"
    --assert* [y == z]

--test-- "Left integer! -> logic!"
    y: none
    z: attempt [fromRight Left 3]
    --assert* [y == z]

--test-- "Left string! -> logic!"
    y: none
    z: attempt [fromRight Left "abc"]
    --assert* [y == z]
===end-group===

===start-group=== "partitionEithers"
--test-- "[Either string! integer!] -> [[string!] [integer!]] 1"
    xs: [Left 1 Right "A" Left 2 Right "B"]
    ys: [[1 2] ["A" "B"]]
    zs: partitionEithers xs
    --assert* [ys == zs]

--test-- "[Either string! integer!] -> [[string!] [integer!]] 2"
    xs: [Left 1 Left 2]
    ys: [[1 2] []]
    zs: partitionEithers xs
    --assert* [ys == zs]
===end-group===

===start-group=== "either'"
--test-- "Either integer! string! -> integer!"
    f: [x] -> [x + 1]
    g: [y] -> [uppercase y]
    y: 4
    z: either' :f :g (Left 3)
    --assert* [y == z]

--test-- "Either integer! string! -> string!"
    f: [x] -> [x + 1]
    g: [y] -> [uppercase y]
    y: "ABC"
    z: either' :f :g (Right "abc")
    --assert* [y == z]

===end-group===

~~~end-file~~~