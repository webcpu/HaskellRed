Red [
    Title:   "Prelude test script"
    Author:  "unchartedworks"
    File: 	 %prelude-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-function.red
#include %data-list.red
#include %data-either.red
#include %prelude.red

~~~start-file~~~ "prelude"

===start-group=== "&&"
--test-- "logic! -> logic! -> logic! 1"
    y: false
    z: false && false
    --assert* [y == z]

--test-- "logic! -> logic! -> logic! 2"
    y: false
    z: false && true
    --assert* [y == z]

--test-- "logic! -> logic! -> logic! 3"
    y: false
    z: true && false
    --assert* [y == z]

--test-- "logic! -> logic! -> logic! 4"
    y: true 
    z: true && true
    --assert* [y == z]
===end-group===

===start-group=== "||"
--test-- "logic! -> logic! -> logic! 1"
    y: false
    z: false || false
    --assert* [y == z]

--test-- "logic! -> logic! -> logic! 2"
    y: true
    z: false || true
    --assert* [y == z]

--test-- "logic! -> logic! -> logic! 3"
    y: true
    z: true || false
    --assert* [y == z]

--test-- "logic! -> logic! -> logic! 4"
    y: true 
    z: true || true
    --assert* [y == z]
===end-group===

===start-group=== "not'"
--test-- "logic! -> logic! 1"
    y: true
    z: not' false
    --assert* [y == z]

--test-- "logic! -> logic! 2"
    y: false
    z: not' true
    --assert* [y == z]
===end-group===

===start-group=== "otherwise"
--test-- "logic! -> logic! 1"
    x: -1
    y: -1
    z: case [x > 0 1 otherwise -1]
    --assert* [y == z]

--test-- "logic! -> logic! 2"
    x: 2
    y: 1 
    z: case [x > 0 1 otherwise -1 (x == 0) 0]
    --assert* [y == z]
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

===start-group=== "fst"
--test-- "pair! -> integer!"
    y: 3
    z: fst 3x5
    --assert* [y == z]

--test-- "[integer!] -> integer! 1"
    y: 1
    z: fst [1 5]
    --assert* [y == z]

--test-- "[integer!] -> integer!"
    y: none
    z: attempt [fst []]
    --assert* [y == z]
===end-group===

===start-group=== "snd"
--test-- "pair! -> integer!"
    y: 5
    z: snd 3x5
    --assert* [y == z]

--test-- "[integer!] -> integer! 1"
    y: 5
    z: snd [1 5]
    --assert* [y == z]

--test-- "[integer!] -> integer!"
    y: none
    z: attempt [snd []]
    --assert* [y == z]
===end-group===

; ===start-group=== "curry"
; --test-- "(integer! -> integer! -> integer!) -> integer! -> (integer! -> integer!) 1"
;     f: curry [x y] -> [x + y] 2
;     y: 6
;     z: f 4
;     --assert* [y == z]

; --test-- "(integer! -> integer! -> integer!) -> integer! -> (integer! -> integer!) 2"
;     f: curry [x y] -> [x * y] 2
;     y: 8
;     z: f 4
;     --assert* [y == z]

; --test-- "(integer! -> integer! -> integer!) -> integer! -> (integer! -> integer!) 3"
;     f: curry [x y] -> [x * y] 2
;     y: 8
;     z: 4 & curry :add 4
;     --assert* [y == z]

; --test-- "(integer! -> integer! -> integer!) -> integer! -> (integer! -> integer!) 4"
;     f: curry [x y z] -> [x + y + z] 1
;     y: none
;     z: attempt [f 2]
;     --assert* [y == z]
; ===end-group===

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

;;Numbers
===start-group=== "abs"
--test-- "integer! -> integer! 1"
    y: 5
    z: abs -5
    --assert* [y == z]

--test-- "integer! -> integer! 2"
    y: 5
    z: abs 5
    --assert* [y == z]

--test-- "integer! -> integer! 3"
    y: 0
    z: abs 0
    --assert* [y == z]

--test-- "float! -> float! 1"
    y: 1.2
    z: abs -1.2
    --assert* [y == z]

--test-- "float! -> float! 2"
    y: 1.2
    z: abs 1.2
    --assert* [y == z]

--test-- "float! -> float! 3"
    y: 0.0
    z: abs 0.0
    --assert* [y == z]
===end-group===

===start-group=== "signum"
--test-- "integer! -> integer! 1"
    y: -1
    z: signum -5
    --assert* [y == z]

--test-- "integer! -> integer! 2"
    y: 1
    z: signum 5
    --assert* [y == z]

--test-- "integer! -> integer! 3"
    y: 0
    z: signum 0
    --assert* [y == z]

--test-- "float! -> float! 1"
    y: -1
    z: signum -1.2
    --assert* [y == z]

--test-- "float! -> float! 2"
    y: 1
    z: signum 1.2
    --assert* [y == z]

--test-- "float! -> float! 3"
    y: 0
    z: signum 0.0
    --assert* [y == z]
===end-group===

===start-group=== "divMod"
--test-- "integer! -> integer! -> integer! 1"
    y: [2 1]
    z: divMod 5 2
    --assert* [y == z]

--test-- "integer! -> integer! -> integer! 2"
    y: [0 1]
    z: divMod 1 9
    --assert* [y == z]

--test-- "integer! -> integer! -> integer3"
    y: [0 0]
    z: divMod 0 9
    --assert* [y == z]
===end-group===

;;Numeric
===start-group=== "even"
--test-- "integer! -> logic! 1"
    y: false 
    z: even 1
    --assert* [y == z]

--test-- "integer! -> logic! 2"
    y: true
    z: even 2 
    --assert* [y == z]

--test-- "integer! -> logic! 3"
    y: true
    z: even 0
    --assert* [y == z]
===end-group===

===start-group=== "odd"
--test-- "integer! -> logic! 1"
    y: true
    z: odd 1
    --assert* [y == z]

--test-- "integer! -> logic! 2"
    y: false
    z: odd 2 
    --assert* [y == z]

--test-- "integer! -> logic! 3"
    y: false
    z: odd 0
    --assert* [y == z]
===end-group===

===start-group=== "until'"
--test-- "(integer! -> logic!) -> (integer! -> integer!) -> 1"
    f: [x] -> [x + 1]
    condition: [x] -> [x > 8]
    y: 9
    z: until' :condition :f 1
    --assert* [y == z]

--test-- "(integer! -> logic!) -> (integer! -> integer!) -> 2"
    f: [x] -> [x - 1]
    condition: [x] -> [x < 8]
    y: 7
    z: until' :condition :f 20
    --assert* [y == z]
===end-group===

~~~end-file~~~