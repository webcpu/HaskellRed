Red [
    Title:   "Prelude test script"
    Author:  "unchartedworks"
    File: 	 %prelude-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-list.red
#include %data-function.red
#include %prelude.red

~~~start-file~~~ "prelude"

===start-group=== "succ"
--test-- "integer! -> integer!"
    y: succ 1
    z: 2
    --assert* [y == z]

--test-- "float! -> float!"
    y: succ 1.2
    z: 2.2
    --assert* [(y - z) < 0.000001]

--test-- "char! -> char! 1"
    y: succ #"a"
    z: #"b"
    --assert* [y == z]

--test-- "char! -> char! 2"
    y: succ #"<"
    z: #"="
    --assert* [y == z]
===end-group===

===start-group=== "pred"
--test-- "integer! -> integer!"
    y: pred 1
    z: 0
    --assert* [y == z]

--test-- "float! -> float!"
    y: pred 1.2
    z: 0.2
    --assert* [(y - z) < 0.000001]

--test-- "char! -> char! 1"
    y: pred #"b"
    z: #"a"
    --assert* [y == z]

--test-- "char! -> char! 2"
    y: pred #"="
    z: #"<"
    --assert* [y == z]
===end-group===

===start-group=== "range"
--test-- "integer! -> integer! -> [integer!] 1"
    ys: range 1 5
    zs: [1 2 3 4 5]
    --assert* [ys == zs]
    
--test-- "integer! -> integer! -> [integer!] 2"
    ys: range 0 0
    zs: [0]
    --assert* [ys == zs]

--test-- "integer! -> integer! -> [integer!] 3"
    ys: range 9 0
    zs: []
    --assert* [ys == zs]
===end-group===

~~~end-file~~~