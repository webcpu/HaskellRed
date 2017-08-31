Red [
    Title:   "Data.List test script"
    Author:  "unchartedworks"
    File: 	 %data-list-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-list.red
#include %data-function.red

~~~start-file~~~ "data-function"

===start-group=== "->"

--test-- "block! -> block! -> function! 1"
    f: [x] -> [x + 1]
    g: function [x][x + 1]
    --assert* [(mold :f) == (mold :g)]
    
--test-- "block! -> block! -> function! 2"
    f: [x y] -> [x + y]
    g: function [x y][x + y]
    --assert* [(mold :f) == (mold :g)]

--test-- "block! -> block! -> function! 3"
    f: [x] -> [y: 1 (x + y)]
    g: function [x][y: 1 (x + y)]
    --assert* [(mold :f) == (mold :g)]
    
--test-- "block! -> block! -> function! 4"
    f: [x y] -> [z: 1 (x + y + z)]
    g: function [x y][z: 1 (x + y + z)]
    --assert* [(mold :f) == (mold :g)]

===end-group===

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

===start-group=== "&"
--test-- "[integer!] -> function! -> [string!]"
    f: function [x][x + 1]
    x: 3
    y: 4
    z: x & :f
    --assert* [y == z]

--test-- "[integer!] -> [function!] -> [string!]"
    to-charint: [x] -> [to-integer #"a" + x]
    to-strings: [xs] -> [map (:to-string . :to-char . :to-charint) xs] 
    ys: "ABCD"
    zs: [0 1 2 3] & :to-strings & :concat & :uppercase
    --assert* [ys == zs]

===end-group===

===start-group=== ">>>="
--test-- "integer! -> [function!] -> integer!"
    f: function [x][x + 1]
    x: 3
    y: 4
    z: x >>>= [f]
    --assert* [y == z]

--test-- "[integer!] -> [any-function!] -> [string!]"
    to-charints: [xs] -> [map ([x] -> [to-integer #"a" + x]) xs]
    to-chars:    [xs] -> [map :to-char xs] 
    to-strings:  function [xs][map :to-string xs]
    ys: "ABCD"
    zs: [0 1 2 3] >>>= [to-charints to-chars to-strings concat uppercase]
    --assert* [ys == zs]

--test-- "path! -> [any-function!] -> integer!"
    file-path: %data-function-test.red
    y: 1
    z: file-path >>>= [read/lines length?]
    --assert* [y < z]
 
 ===end-group===

~~~end-file~~~