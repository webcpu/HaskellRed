Red [
    Title:   "Data.List test script"
    Author:  "unchartedworks"
    File: 	 %data-list-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red
#include %data-function.red

~~~start-file~~~ "data-function"

===start-group=== "id"
--test-- "integer! -> string!"
    xs: 1
    ys: 1
    zs: id xs
    --assert* [ys == zs]
    
--test-- "string! -> string!"
    xs: "abc"
    ys: "abc"
    zs: id xs
    --assert* [ys == zs]

--test-- "word! -> word!"
    xs: 'x
    ys: 'x
    zs: id xs
    --assert* [ys == zs]

--test-- "function! -> function!"
    xs: func [x][x + 1]
    ys: mold func [x][x + 1]
    zs: mold (id :xs)
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!]"
    xs: [1 2 3]
    ys: [1 2 3]
    zs: id xs
    --assert* [ys == zs]

===end-group===

===start-group=== "const"
--test-- "integer! -> integer! -> string!"
    xs: 1
    ys: 1
    zs: const xs 3
    --assert* [ys == zs]
    
--test-- "string! -> integer! -> string!"
    xs: "abc"
    ys: "abc"
    zs: const xs 8
    --assert* [ys == zs]

--test-- "word! -> string! -> word!"
    xs: 'x
    ys: 'x
    zs: const xs "ab"
    --assert* [ys == zs]

--test-- "any-function! -> any-function! -> any-function!"
    xs: func [x][x + 1]
    ys: mold func [x][x + 1]
    zs: mold (const :xs :positive?)
    --assert* [ys == zs]

--test-- "[integer!] -> integer! -> [integer!]"
    xs: [1 2 3]
    ys: [1 2 3]
    zs: const xs 9
    --assert* [ys == zs]

===end-group===

===start-group=== "."
--test-- "(integer! -> integer!) -> (integer! -> integer!) -> (integer! -> integer!) 1"
    f1: func [x][x + 1]
    f2: func [x][x * 2]
    f:  :f1 . :f2
    ys: 7
    zs: f 3
    --assert* [ys == zs]
    
--test-- "(integer! -> integer!) -> (integer! -> integer!) -> (integer! -> integer!) 2"
    f1: func [x][x + 1]
    f2: func [x][x * 2]
    f:  :f1 . :f2 . :f2 . :f2
    ys: 25
    zs: f 3
    --assert* [ys == zs]

--test-- "(string! -> integer!) -> (integer! -> integer!) -> (string! -> integer!) 1"
    f1: func [x][x * 2]
    f2: func [x][length? x]
    f:  :f1 . :f2
    ys: 6
    zs: f "abc"
    --assert* [ys == zs]
    
--test-- "(string! -> integer!) -> (integer! -> integer!) -> (string! -> integer!) 2"
    f1: func [x][x * 2]
    f2: func [x][length? x]
    f:  :f1 . :f1 . :f1 . :f2
    ys: 24
    zs: f "abc"
    --assert* [ys == zs]

===end-group===

===start-group=== "flip"
--test-- "integer! -> integer! -> logic! -> integer! -> integer!"
    ys: true
    zs: flip func [x y][x > y] 1 2
    --assert* [ys == zs]
    
--test-- "string! -> integer! -> logic! -> integer! -> string!"
    ys: true
    zs: flip func [s x][(length? s) > x] 1 "abc"
    --assert* [ys == zs]

===end-group===

~~~end-file~~~