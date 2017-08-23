Red [
    Title:   "Data.List test script"
    Author:  "unchartedworks"
    File: 	 %data-list-test.red
    Tabs:	   4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red
#include %data-list.red

~~~start-file~~~ "data-list"

===start-group=== "+"

--test-- "integer! -> integer! -> integer!"
    xs1: 2
    xs2: 1
    ys: 3
    zs: xs1 + xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!]"
    xs1: [4 5 6]
    xs2: [1 2 3]
    ys: [5 7 9]
    zs: xs1 + xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!]"
    xs1: [1 2 3 7]
    xs2: [1 2 3]
    ys: Nothing
    zs: xs1 + xs2
    --assert* [ys == zs]

===end-group===

===start-group=== "-"

--test-- "integer! -> integer! -> integer!"
    xs1: 2
    xs2: 1
    ys: 1
    zs: xs1 - xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!]"
    xs1: [4 5 6]
    xs2: [1 2 3]
    ys: [3 3 3]
    zs: xs1 - xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!]"
    xs1: [1 2 3 7]
    xs2: [1 2 3]
    ys: Nothing
    zs: xs1 - xs2
    --assert* [ys == zs]

===end-group===

===start-group=== "*"

--test-- "integer! -> integer! -> integer! 1"
    xs1: 2
    xs2: 5 
    ys: 10
    zs: xs1 * xs2
    --assert* [ys == zs]

--test-- "integer! -> integer! -> integer! 2"
    xs1: 2 + 7
    xs2: 5 
    ys: 45
    zs: xs1 * xs2
    --assert* [ys == zs]

--test-- "integer! -> integer! -> integer! 3"
    xs1: add 1 1
    xs2: 5 
    ys: 10
    zs: xs1 * xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!] 1"
    xs1: [4 5 6]
    xs2: [1 2 3]
    ys: [4 10 18]
    zs: xs1 * xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!] 2"
    xs1: [1 2 3 7]
    xs2: [1 2 3]
    ys: Nothing
    zs: xs1 * xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!] 3"
    xs1: [4 + 8 5 6]
    xs2: [1 2 3]
    ys: [12 10 18]
    zs: xs1 * xs2
    print "==========="
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!] 3"
    ;xs1: [[[[add 1 2 add 3 4]]] [[[add 3 4 add 5 6]]]]
    ;xs2: [[[[add 1 2 add 3 4]]] [[[add 3 4 add 5 6]]]]
    ;ys: [[[[6 7]]] [[[7 11]]]]
    ;zs: xs1 + xs2
    ;--assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!] 4"
    xs1: [add 1 3 5 6]
    xs2: [1 2 3 * 2]
    ys: [4 10 36]
    zs: xs1 * xs2
    --assert* [ys == zs]

===end-group===

===start-group=== "++"
--test-- "[integer!] -> [integer!] -> [string!]"
    xs1: [1 2 3]
    xs2: [4 5 6]
    ys: [1 2 3 4 5 6]
    zs: xs1 ++ xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [string!] -> [string!]"
    xs1: [1 2 3]
    xs2: ["4" "5" "6"]
    ys: [1 2 3 "4" "5" "6"]
    zs: xs1 ++ xs2
    --assert* [ys == zs]

--test-- "[string!] -> [string!] -> [string!]"
    xs1: "abc"
    xs2: "def"
    ys:  "abcdef"
    zs:   xs1 ++ xs2
    --assert* [ys == zs]

--test-- "[integer!] -> string! -> [string!]"
    xs1: [1 2 3]
    xs2: ["abc"]
    ys:  [1 2 3 "abc"]
    zs:   xs1 ++ xs2
    --assert* [ys == zs]

--test-- "[integer!] -> string! -> [string!]"
    xs1: "abc"
    xs2: [1 2 3]
    ys:  "abc123"
    zs:   xs1 ++ xs2
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!] -> [integer!] -> [string!]"
    xs1: [1 2 3]
    xs2: [4 5 6]
    xs3: [7 8 9]
    ys: [1 2 3 4 5 6 7 8 9]
    zs: xs1 ++ xs2 ++ xs3
    --assert* [ys == zs]

--test-- "[integer!] -> [string!] -> [integer!] -> [string!]"
    xs1: [1 2 3]
    xs2: ["4" "5" "6"]
    xs3: [7 8 9]
    ys: [1 2 3 "4" "5" "6" 7 8 9]
    zs: xs1 ++ xs2 ++ xs3
    --assert* [ys == zs]

--test-- "[[integer!]] -> [integer!] -> [[integer!] | integer!]"
    xs1: [[1] [2] [3]]
    xs2: [4 5 6]
    ys: [[1] [2] [3] 4 5 6]
    zs: xs1 ++ xs2
    --assert* [ys == zs]

===end-group===

===start-group=== "rest"
--test-- "[integer!] -> [integer!]"
    xs: [1 2 3]
    ys: [2 3]
    zs: rest xs
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!]"
    xs: [1]
    ys: []
    zs: rest xs
    --assert* [ys == zs]

--test-- "[string!] -> [string!]"
    xs: ["1" "2" "3"]
    ys: ["2" "3"]
    zs: rest xs
    --assert* [ys == zs]

--test-- "[string!] -> [string!]"
    xs: ["1"]
    ys: []
    zs: rest xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "abc"
    ys: "bc"
    zs: rest xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "a"
    ys: ""
    zs: rest xs
    --assert* [ys == zs]

===end-group===

===start-group=== "init"
--test-- "[integer!] -> [integer!]"
    xs: [1 2 3]
    ys: [1 2]
    zs1: init xs
    zs2: most xs
    --assert* [ys == zs1]
    --assert* [ys == zs2]

--test-- "[integer!] -> [integer!]"
    xs: [1]
    ys: []
    zs1: init xs
    zs2: most xs
    --assert* [ys == zs1]
    --assert* [ys == zs2]

--test-- "[string!] -> [string!] 1"
    xs: ["1" "2" "3"]
    ys: ["1" "2"]
    zs1: init xs
    zs2: most xs
    --assert* [ys == zs1]
    --assert* [ys == zs2]

--test-- "[string!] -> [string!] 2"
    xs: ["1"]
    ys: []
    zs1: init xs
    zs2: most xs
    --assert* [ys == zs1]
    --assert* [ys == zs2]

--test-- "string! -> string! 1"
    xs: "abc"
    ys: "ab"
    zs1: init xs
    zs2: most xs
    --assert* [ys == zs1]
    --assert* [ys == zs2]

--test-- "string! -> string! 2"
    xs: "a"
    ys: ""
    zs1: init xs
    zs2: most xs
    --assert* [ys == zs1]
    --assert* [ys == zs2]

===end-group===

===start-group=== "uncons"
--test-- "[integer!] -> [integer! [integer!]]"
    xs: [1 2 3]
    ys: [1 [2 3]]
    zs: uncons xs
    --assert* [ys == zs]

--test-- "[integer!] -> [integer!]"
    xs: [1]
    ys: [1 []]
    zs: uncons xs
    --assert* [ys == zs]

--test-- "[string!] -> [string!]"
    xs: ["1" "2" "3"]
    ys: ["1" ["2" "3"]]
    zs: uncons xs
    --assert* [ys == zs]

--test-- "[string!] -> [string!]"
    xs: ["1"]
    ys: ["1" []]
    zs: uncons xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "abc"
    ys: [#"a" "bc"]
    zs: uncons xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "a"
    ys: [#"a" ""]
    zs: uncons xs
    --assert* [ys == zs]

--test-- "[] -> Maybe"
    xs: []
    ys: Nothing
    zs: uncons xs
    --assert* [ys == zs]

--test-- "string! -> Maybe"
    xs: ""
    ys: Nothing
    zs: uncons xs
    --assert* [ys == zs]

===end-group===

===start-group=== "length"
--test-- "[integer!] -> integer!"
    xs: [1 2 3]
    ys: 3
    zs: length xs
    --assert* [ys == zs]

--test-- "[string!] -> integer!"
    xs: ["ab" "cd" "ef"]
    ys: 3
    zs: length xs
    --assert* [ys == zs]

--test-- "[] -> integer!"
    xs: []
    ys: 0
    zs: length xs
    --assert* [ys == zs]

--test-- "string! -> integer!"
    xs: "abcdef"
    ys: 6
    zs: length xs
    --assert* [ys == zs]

--test-- "string! -> integer!"
    xs: ""
    ys: 0
    zs: length xs
    --assert* [ys == zs]

===end-group===

===start-group=== "map"
--test-- "[integer!] -> [string!]"
    xs: [1 2 3]
    ys: ["1" "2" "3"]
    zs: map :to-string xs
    --assert* [ys == zs]

--test-- "[char!] -> [string!]"
    xs: [#"1" #"2" #"3"]
    ys: ["1" "2" "3"]
    zs: map :to-string xs
    --assert* [ys == zs]

--test-- "[integer!] -> [[string!]]"
    xs: [#"1" #"2" #"3"]
    ys: [["1"] ["2"] ["3"]]
    f: func [x][reduce [to-string x]]
    zs: map :f xs
    --assert* [ys == zs]

--test-- "[[integer!]] -> [[integer!]]"
    xs: [[1] [2] [3]]
    ys: [[2] [3] [4]]
    f: func [x][reduce [add first x 1]]
    zs: map :f xs
    --assert* [ys == zs]

--test-- "[[integer!]] -> [[[integer!]]]"
    xs: [[1] [2] [3]]
    ys: [[[2]] [[3]] [[4]]]
    f: func [x][reduce [reduce [add first x 1]]]
    zs: map :f xs
    --assert* [ys == zs]

--test-- "[[string!]] -> [[[string!]]]"
    xs: [["ab"] ["bc"] ["cd"]]
    ys: [[["AB"]] [["BC"]] [["CD"]]]
    f: func [x][reduce [reduce [uppercase first x]]]
    zs: map :f xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "abc"
    ys: "ABC"
    f: func [x][reduce [to-string x]]
    zs: map :uppercase xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "abc"
    ys: "ABC"
    f: func [x][reduce [to-string x]]
    zs: map :uppercase xs
    --assert* [ys == zs]    
===end-group===

===start-group=== "reverse"
--test-- "[integer!] -> [integer!]"
    xs: [1 2 3]
    ys: [3 2 1]
    zs: reverse xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "abc"
    ys: "cba"
    zs: reverse xs
    --assert* [ys == zs]
===end-group===

===start-group=== "intersperse"
--test-- "integer! -> [integer!] -> [integer!]"
     x: 0
    xs: [1 2 3]
    ys: [1 0 2 0 3]
    zs: intersperse x xs
    --assert* [ys == zs]

--test-- "string! -> string!"
     y: #","
    xs: "abc"
    ys: "cba"
    zs: reverse xs
    --assert* [ys == zs]

===end-group===

===start-group=== "transpose"
--test-- "[[integer!]] -> [[integer!]] -> [[string!]]"
    xss1:  []
    xss2:  [[] [] []]
    xss3:  [[1] [3] [6]]
    xss4:  [[1 2 3] [4 5 6]]
    xss5:  [[1 2 3] [4 5 6] 6]
    yss1:  []
    yss2:  []
    yss3:  [[1 3 6]]
    yss4:  [[1 4] [2 5] [3 6]]
    yss5:  none
    zss1:  (transpose xss1)
    zss2:  (transpose xss2)
    zss3:  (transpose xss3)
    zss4:  (transpose xss4)
    zss5:  (transpose xss5)

    --assert* [yss1 == zss1]
    --assert* [yss2 == zss2]
    --assert* [yss3 == zss3]
    --assert* [yss4 == zss4]
    --assert* [yss5 == zss5]

--test-- "[string!] -> [string!] -> [string!]"
    xss1:  []
    xss2:  [[] [] []]
    xss3:  [["1"] ["3"] ["6"]]
    xss4:  [["1" "2" "3"] ["4" "5" "6"]]
    xss5:  [["1" "2" "3"] ["4" "5" "6"] "6"]
    yss1:  []
    yss2:  []
    yss3:  [["1" "3" "6"]]
    yss4:  [["1" "4"] ["2" "5"] ["3" "6"]]
    yss5:  none
    zss1:  (transpose xss1)
    zss2:  (transpose xss2)
    zss3:  (transpose xss3)
    zss4:  (transpose xss4)
    zss5:  (transpose xss5)

    --assert* [yss1 == zss1]
    --assert* [yss2 == zss2]
    --assert* [yss3 == zss3]
    --assert* [yss4 == zss4]
    --assert* [yss5 == zss5]

--test-- "[string!] -> [string!] -> [string!]"
    xss1:  []
    xss2:  [[] [] []]
    xss3:  [["1"] ["3"] ["6"]]
    xss4:  [["1" "2" "3"] [4 5 6]]
    xss5:  [["1" "2" "3"] [4 5 6] "6"]
    yss1:  []
    yss2:  []
    yss3:  [["1" "3" "6"]]
    yss4:  [["1" 4] ["2" 5] ["3" 6]]
    yss5:  none
    zss1:  (transpose xss1)
    zss2:  (transpose xss2)
    zss3:  (transpose xss3)
    zss4:  (transpose xss4)
    zss5:  (transpose xss5)

===end-group===

===start-group=== "subsequences"
--test-- "[integer!] -> [integer!]"
    xs: [1 2]
    ys: [[] [1] [2] [1 2] [3] [1 3] [2 3] [1 2 3]]
    ;zs: subsequences xs
    ;--assert* [ys == zs]
    print mold (subsequences [1 2])

--test-- "string! -> string!"
    xs: "abc"
    ys: "bc"
    zs: filter func [x][x > #"a"] xs
    --assert* [ys == zs]

--test-- "block! -> block!"
    xs: [1 "2" 3 "4" 5 "6"]
    ys1: [1 3 5]
    ys2: ["2" "4" "6"]
    zs1: filter :integer? xs
    zs2: filter :string? xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "[[integer!]] -> [[integer!]]"
    xs: [[1] [1 2] [1 2 3]]
    ys1: [[1]]
    ys2: [[1 2] [1 2 3]]
    zs1: filter func [x][2 > length? x] xs
    zs2: filter func [x][2 <= length? x] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

===end-group===

===start-group=== "filter"
--test-- "[integer!] -> [integer!]"
    xs: [1 2 3]
    ys: [2 3]
    zs: filter func [x][x > 1] xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "abc"
    ys: "bc"
    zs: filter func [x][x > #"a"] xs
    --assert* [ys == zs]

--test-- "block! -> block!"
    xs: [1 "2" 3 "4" 5 "6"]
    ys1: [1 3 5]
    ys2: ["2" "4" "6"]
    zs1: filter :integer? xs
    zs2: filter :string? xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "[[integer!]] -> [[integer!]]"
    xs: [[1] [1 2] [1 2 3]]
    ys1: [[1]]
    ys2: [[1 2] [1 2 3]]
    zs1: filter func [x][2 > length? x] xs
    zs2: filter func [x][2 <= length? x] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

===end-group===

===start-group=== "zip"

--test-- "[integer!] -> [integer!] -> [[integer!]]"
    xs1: [1 2 3]
    xs2: [4 5 6]
    yss: [[1 4] [2 5] [3 6]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[integer!] -> string! -> [[integer! | char!]]"
    xs1: [1 2 3]
    xs2: "abc"
    yss: [[1 #"a"] [2 #"b"] [3 #"c"]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[string!] -> [string!] -> [[string!]]"
    xs1: ["a" "bc" "def"]
    xs2: ["b" "de" "ghi"]
    yss: [["a" "b"] ["bc" "de"] ["def" "ghi"]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[string!] -> [integer!] -> [[string! | integer!]]"
    xs1: ["a" "bc" "def"]
    xs2: [1 2 3]
    yss: [["a" 1] ["bc" 2] ["def" 3]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "string! -> string! -> [[char!]] 1"
    xs1: "abc"
    xs2: "123"
    yss: [[#"a" #"1"] [#"b" #"2"] [#"c" #"3"]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "string! -> string! -> [[char!]] 2"
    xs1: "abcb"
    xs2: "123"
    yss: [[#"a" #"1"] [#"b" #"2"] [#"c" #"3"]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[[integer!]] -> [[integer!]] -> [[[integer!]]]"
    xs1: [[1] [2] [3]]
    xs2: [[4] [5] [6]]
    yss: [[[1] [4]] [[2] [5]] [[3] [6]]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[[integer!]] -> [[integer!]] -> [[[integer!]]] 2"
    xs1: [[1] [2] [3]]
    xs2: [[4] [5] [6] [7]]
    yss: [[[1] [4]] [[2] [5]] [[3] [6]]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[[string!]] -> [[string!]] -> [[[string!]]] 1"
    xs1: [["a"] ["b"] ["c"]]
    xs2: [["d"] ["e"] ["f"]]
    yss: [[["a"] ["d"]] [["b"] ["e"]] [["c"] ["f"]]]
    zss: zip xs1 xs2
    --assert* [yss == zss]

--test-- "[[string!]] -> [[string!]] -> [[[string!]]] 2"
    xs1: [["a"] ["b"] ["c"] "e"]
    xs2: [["d"] ["e"] ["f"]]
    yss: [[["a"] ["d"]] [["b"] ["e"]] [["c"] ["f"]]]
    zss: zip xs1 xs2
    zip "hello" 1
    --assert* [yss == zss]
===end-group===

===start-group=== "reduce-deep"

--test-- "[[[integer] [integer!]]] -> [[[integer] [integer!]]]"
    xss: [add 1 2 add 3 4 add 3 4 add 5 6]
    yss: [3 7 7 11]
    zss: reduce-deep xss
    --assert* [yss == zss]

--test-- "[[[integer] [integer!]]] -> [[[integer] [integer!]]]"
    xss: [[add 1 2 add 3 4] [add 3 4 add 5 6]]
    yss: [[3 7] [7 11]]
    zss: reduce-deep xss
    --assert* [yss == zss]

--test-- "[[[integer] [integer!]]] -> [[[integer] [integer!]]]"
    xss: [[[add 1 2 add 3 4]] [[add 3 4 add 5 6]]]
    yss: [[[3 7]] [[7 11]]]
    zss: reduce-deep xss
    --assert* [yss == zss]

--test-- "[[[[integer] [integer!]]]] -> [[[[integer] [integer!]]]]"
    xss: [[[[add 1 2 add 3 4]]] [[[add 3 4 add 5 6]]]]
    yss: [[[[3 7]]] [[[7 11]]]]
    zss: reduce-deep xss
    --assert* [yss == zss]
===end-group===

~~~end-file~~~