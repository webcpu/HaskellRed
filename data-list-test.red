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
    zs: map :uppercase xs
    --assert* [ys == zs]

--test-- "string! -> string!"
    xs: "123"
    ys: [1 2 3]
    f: func [x][do (to-string x)]
    zs: map :f xs
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

--test-- "[integer!] -> [[integer!]]"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: [[]]
    ys2: [[] [1]]
    ys3: [[] [1] [2] [1 2]]
    ys4: [[] [1] [2] [1 2] [3] [1 3] [2 3] [1 2 3]]
    zs1: subsequences xs1
    zs2: subsequences xs2
    zs3: subsequences xs3
    zs4: subsequences xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "[string!] -> [[string!]]"
    xs1: []
    xs2: ["1"]
    xs3: ["1" "2"]
    xs4: ["1" "2" "3"]
    ys1: [[]]
    ys2: [[] ["1"]]
    ys3: [[] ["1"] ["2"] ["1" "2"]]
    ys4: [[] ["1"] ["2"] ["1" "2"] ["3"] ["1" "3"] ["2" "3"] ["1" "2" "3"]]
    zs1: subsequences xs1
    zs2: subsequences xs2
    zs3: subsequences xs3
    zs4: subsequences xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "[string! | integer!] -> [[string! | integer!]]"
    xs1: []
    xs2: ["1"]
    xs3: ["1" 2]
    xs4: ["1" 2 "3"]
    ys1: [[]]
    ys2: [[] ["1"]]
    ys3: [[] ["1"] [2] ["1" 2]]
    ys4: [[] ["1"] [2] ["1" 2] ["3"] ["1" "3"] [2 "3"] ["1" 2 "3"]]
    zs1: subsequences xs1
    zs2: subsequences xs2
    zs3: subsequences xs3
    zs4: subsequences xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [[string!]"
    xs1: ""
    xs2: "ab"
    xs3: "abc"
    ys1: [""]
    ys2: ["" "a" "b" "ab"]
    ys3: ["" "a" "b" "ab" "c" "ac" "bc" "abc"]
    zs1: subsequences xs1
    zs2: subsequences xs2
    zs3: subsequences xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

===end-group===

===start-group=== "permutations"

--test-- "[integer!] -> [[integer!]]"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: [[]]
    ys2: [[1]]
    ys3: [[1 2] [2 1]]
    ys4: [[1 2 3] [2 1 3] [2 3 1] [1 3 2] [3 1 2] [3 2 1]]
    zs1: permutations xs1
    zs2: permutations xs2
    zs3: permutations xs3
    zs4: permutations xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "[string!] -> [[string!]]"
    xs1: []
    xs2: ["1"]
    xs3: ["1" "2"]
    xs4: ["1" "2" "3"]
    ys1: [[]]
    ys2: [["1"]]
    ys3: [["1" "2"] ["2" "1"]]
    ys4: [["1" "2" "3"] ["2" "1" "3"] ["2" "3" "1"] ["1" "3" "2"] ["3" "1" "2"] ["3" "2" "1"]]
    zs1: permutations xs1
    zs2: permutations xs2
    zs3: permutations xs3
    zs4: permutations xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "[string! | integer!] -> [[string! | integer!]]"
    xs1: []
    xs2: ["1"]
    xs3: ["1" 2]
    xs4: ["1" 2 "3"]
    ys1: [[]]
    ys2: [["1"]]
    ys3: [["1" 2] [2 "1"]]
    ys4: [["1" 2 "3"] [2 "1" "3"] [2 "3" "1"] ["1" "3" 2] ["3" "1" 2] ["3" 2 "1"]]
    zs1: permutations xs1
    zs2: permutations xs2
    zs3: permutations xs3
    zs4: permutations xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [[string!]"
    xs1: ""
    xs2: "ab"
    xs3: "abc"
    ys1: [""]
    ys2: ["ab" "ba"]
    ys3: ["abc" "bac" "bca" "acb" "cab" "cba"]
    zs1: permutations xs1
    zs2: permutations xs2
    zs3: permutations xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

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

===start-group=== "foldl"

--test-- "(b -> a -> b) -> b -> [b] -> a 1"
    xs: [1 2 3]
    ys: 6
    f: func [y x][x + y]
    zs: foldl :f 0 xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 2"
    xs: [1 2 3 4]
    ys: 24
    f: func [y x][x * y]
    zs: foldl :f 1 xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 3"
    xs: [1 2 3 4]
    ys: [[1] [2] [3] [4]]
    f: func [y x][y ++ (reduce [reduce [x]])]
    zs: foldl :f [] xs
    --assert* [ys == zs]

===end-group===

===start-group=== "foldl1"
--test-- "(a -> a -> a) -> [a] -> a 1"
    xs1: []
    xs2: [1 2 3]
    ys1: none
    ys2: 6
    f: func [y x][x + y]
    zs1: foldl1 :f xs1
    zs1: foldl1 :f xs2
    --assert* [ys == zs]

--test-- "(a -> a -> a) -> [a] -> a 2"
    xs: [1 2 3 4]
    ys: 24
    f: func [y x][x * y]
    zs: foldl1 :f xs
    --assert* [ys == zs]

===end-group===

===start-group=== "foldr"

--test-- "(a -> b -> a) -> a -> [b] -> a 1"
    xs: [1 2 3]
    ys: 6
    f: func [x y][x + y]
    zs: foldr :f 0 xs
    --assert* [ys == zs]

--test-- "(a -> b -> a) -> a -> [b] -> a 2"
    xs: [1 2 3 4]
    ys: 24
    f: func [x y][x * y]
    zs: foldr :f 1 xs
    --assert* [ys == zs]

--test-- "(a -> b -> a) -> a -> [b] -> a 3"
    xs: [1 2 3 4]
    ys: [[1] [2] [3] [4]]
    f: func [x y][(reduce [reduce [x]]) ++ y]
    zs: foldr :f [] xs
    --assert* [ys == zs]

===end-group===

===start-group=== "foldr1"
--test-- "(a -> a -> a) -> [a] -> a 1"
    xs1: []
    xs2: [1 2 3]
    ys1: none
    ys2: 6
    f: func [x y][x + y]
    zs1: foldr1 :f xs1
    zs2: foldr1 :f xs2
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "(a -> a -> a) -> [a] -> a 2"
    xs: ["1" "2" "3" "4"]
    ys: "1234"
    f: func [x y][ x ++ y]
    zs: foldr1 :f xs
    --assert* [ys == zs]

===end-group===

===start-group=== "concat"
--test-- "[[integer!]] -> [integer!]"
    xs1: []
    xs2: [[1] [2] [3]]
    ys1: []
    ys2: [1 2 3]
    zs1: concat xs1
    zs2: concat xs2
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "[[string!]] -> [string!]"
    xs1: []
    xs2: [["1"] ["2"] ["3"]]
    ys1: []
    ys2: ["1" "2" "3"]
    zs1: concat xs1
    zs2: concat xs2
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "[string!] -> string!"
    xs: ["1" "2" "3"]
    ys: "123"
    zs: concat xs
    --assert* [ys == zs]

===end-group===

===start-group=== "concatMap"
--test-- "(integer! -> [integer!]) -> [integer!] -> [integer!]"
    xs: [1 2 3]
    ys: [1 2 3]
    zs: concatMap func [x][reduce [x]] xs
    --assert* [ys == zs]

--test-- "(string! -> [string!]) -> [string!] -> [string!]"
    xs: ["1" "2" "3"]
    ys: ["1" "1" "2" "2" "3" "3"]
    zs: concatMap func [x][reduce [x x]] xs
    --assert* [ys == zs]

--test-- "(character! -> string!) -> string! -> string!"
    xs: "abc"
    ys: "aabbcc"
    zs: concatMap func [x][(to-string x) ++ (to-string x)] xs
    --assert* [ys == zs]

--test-- "(character! -> string!) -> string! -> string!"
    xs: "abc"
    ys: ["a" "a" "b" "b" "c" "c"]
    zs: concatMap func [x][reduce [(to-string x) (to-string x)]] xs
    --assert* [ys == zs]
    
===end-group===

===start-group=== "sum"
--test-- "[integer!] -> integer!"
    xs1: []
    xs2: [1]
    xs3: [1 2 3 4]
    ys1: 0
    ys2: 1
    ys3: 10
    zs1: sum xs1
    zs2: sum xs2
    zs3: sum xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

===end-group===

===start-group=== "product"

--test-- "[integer!] -> integer!"
    xs1: []
    xs2: [1]
    xs3: [1 2 3 4]
    ys1: 1
    ys2: 1
    ys3: 24
    zs1: product xs1
    zs2: product xs2
    zs3: product xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

===end-group===

===start-group=== "maximum"

--test-- "[integer!] -> integer!"
    xs1: []
    xs2: [1]
    xs3: [1 2 3 4]
    ys1: none
    ys2: 1
    ys3: 4
    zs1: maximum xs1
    zs2: maximum xs2
    zs3: maximum xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

--test-- "[string!] -> integer!"
    xs1: []
    xs2: ["1"]
    xs3: ["1" 2 3 4]
    ys1: none
    ys2: none
    ys3: none
    zs1: maximum xs1
    zs2: maximum xs2
    zs3: maximum xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

===end-group===

===start-group=== "minimum"

--test-- "[integer!] -> integer!"
    xs1: []
    xs2: [1]
    xs3: [1 2 3 4]
    ys1: none
    ys2: 1
    ys3: 1
    zs1: minimum xs1
    zs2: minimum xs2
    zs3: minimum xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

--test-- "[string!] -> integer!"
    xs1: []
    xs2: ["1"]
    xs3: ["1" 2 3 4]
    ys1: none
    ys2: none
    ys3: none
    zs1: minimum xs1
    zs2: minimum xs2
    zs3: minimum xs3
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

===end-group===

===start-group=== "scanl"

--test-- "(b -> a -> b) -> b -> [b] -> a 1"
    xs: [1 2 3]
    ys: [0 1 3 6]
    f: func [y x][x + y]
    zs: scanl :f 0 xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 2"
    xs: [1 2 3 4]
    ys: [1 1 2 6 24]
    f: func [y x][x * y]
    zs: scanl :f 1 xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 3"
    xs: [1 2 3 4]
    ys: [[] [1] [1 2] [1 2 3] [1 2 3 4]]
    f: func [y x][y ++ (reduce [x])]
    zs: scanl :f [] xs
    --assert* [ys == zs]

--test-- "(string! -> char! -> string!) -> string! -> [string!]"
    xs: "abc"
    ys: ["" "a" "ab" "abc"]
    f: func [y x][y ++ (reduce [x])]
    zs: scanl :f "" xs
    --assert* [ys == zs]

===end-group===

===start-group=== "scanl1"

--test-- "(b -> a -> b) -> b -> [b] -> a 1"
    xs: [1 2 3]
    ys: [1 3 6]
    f: func [y x][x + y]
    zs: scanl1 :f xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 2"
    xs: [1 2 3 4]
    ys: [1 2 6 24]
    f: func [y x][x * y]
    zs: scanl1 :f xs
    --assert* [ys == zs]
===end-group===

 ===start-group=== "scanr"

--test-- "(b -> a -> b) -> b -> [b] -> a 1"
    xs: [1 2 3]
    ys: [6 5 3 0]
    f: func [x y][x + y]
    zs: scanr :f 0 xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 2"
    xs: [1 2 3 4]
    ys: [24 24 12 4 1]
    f: func [x y][x * y]
    zs: scanr :f 1 xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 3"
    xs: [1 2 3 4]
    ys: [[4 3 2 1] [4 3 2] [4 3] [4] []]
    f: func [x y][y ++ (reduce [x])]
    zs: scanr :f [] xs
    --assert* [ys == zs]

--test-- "(char! -> string! -> string!) -> string! -> [string!]"
    xs: "abc"
    ys: ["abc" "bc" "c" ""]
    f: func [x y][(to-string x) ++ y]
    zs: scanr :f "" xs
    --assert* [ys == zs]

 ===end-group===

===start-group=== "scanr1"

--test-- "(b -> a -> b) -> b -> [b] -> a 1"
    xs: [1 2 3]
    ys: [6 5 3]
    f: func [x y][x + y]
    zs: scanr1 :f xs
    --assert* [ys == zs]

--test-- "(b -> a -> b) -> b -> [b] -> a 2"
    xs: [1 2 3 4]
    ys: [24 24 12 4]
    f: func [x y][x * y]
    zs: scanr1 :f xs
    --assert* [ys == zs]
===end-group===

===start-group=== "replicate"

--test-- "integer! -> integer! -> [any-type!]"
    ys1: []
    ys2: [1]
    ys3: [1 1]
    zs1: replicate 0 1
    zs2: replicate 1 1
    zs3: replicate 2 1
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

--test-- "integer! -> string! -> [string!]"
    ys1: []
    ys2: ["abc"]
    ys3: ["abc" "abc"]
    zs1: replicate 0 "abc"
    zs2: replicate 1 "abc"
    zs3: replicate 2 "abc"
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

--test-- "integer! -> char! -> string!"
    ys1: ""
    ys2: "a"
    ys3: "aa"
    zs1: replicate 0 #"a"
    zs2: replicate 1 #"a"
    zs3: replicate 2 #"a"
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]

===end-group===

===start-group=== "take'"

--test-- "integer! -> integer! -> [any-type!]"
    xs:  [1 2 3]
    ys1: []
    ys2: [1]
    ys3: [1 2]
    ys4: [1 2 3]
    ys5: [1 2 3]
    zs1: take' 0 xs
    zs2: take' 1 xs
    zs3: take' 2 xs
    zs4: take' 3 xs
    zs5: take' 4 xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "integer! -> string! -> [string!]"
    xs:  "abc"
    ys1: ""   
    ys2: "a"  
    ys3: "ab" 
    ys4: "abc"
    ys5: "abc"
    zs1: take' 0 xs
    zs2: take' 1 xs
    zs3: take' 2 xs
    zs4: take' 3 xs
    zs5: take' 4 xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "drop"

--test-- "integer! -> integer! -> [any-type!]"
    xs:  [1 2 3]
    ys1: [1 2 3]
    ys2: [2 3]
    ys3: [3]
    ys4: []
    ys5: []
    zs1: drop 0 xs
    zs2: drop 1 xs
    zs3: drop 2 xs
    zs4: drop 3 xs
    zs5: drop 4 xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "integer! -> string! -> [string!]"
    xs:  "abc"
    ys1: ""   
    ys2: "a"  
    ys3: "ab" 
    ys4: "abc"
    ys5: "abc"
    zs1: take' 0 xs
    zs2: take' 1 xs
    zs3: take' 2 xs
    zs4: take' 3 xs
    zs5: take' 4 xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "splitAt"

--test-- "integer! -> integer! -> [any-type!]"
    xs:  [1 2 3]
    ys1: [[] [1 2 3]]
    ys2: [[1] [2 3]]
    ys3: [[1 2] [3]]
    ys4: [[1 2 3] []]
    ys5: [[1 2 3] []]
    zs1: splitAt 0 xs
    zs2: splitAt 1 xs
    zs3: splitAt 2 xs
    zs4: splitAt 3 xs
    zs5: splitAt 4 xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "integer! -> string! -> [string!]"
    xs:  "abc"
    ys1: ["" "abc"]   
    ys2: ["a" "bc"] 
    ys3: ["ab" "c"]
    ys4: ["abc" ""]
    ys5: ["abc" ""]
    zs1: splitAt 0 xs
    zs2: splitAt 1 xs
    zs3: splitAt 2 xs
    zs4: splitAt 3 xs
    zs5: splitAt 4 xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "takeWhile"

--test-- "(integer! -> logic!) -> [any-type!]"
    xs:  [1 2 3]
    ys1: [1 2 3]
    ys2: []
    ys3: [1]
    ys4: [1 2]
    ys5: [1 2 3]
    zs1: takeWhile :positive? xs
    zs2: takeWhile func[x][x < 1] xs
    zs3: takeWhile func[x][x < 2] xs
    zs4: takeWhile func[x][x < 3] xs
    zs5: takeWhile func[x][x < 4] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "integer! -> string! -> [string!]"
    xs:  "abc"
    ys1: ""   
    ys2: "a"  
    ys3: "ab" 
    ys4: "abc"
    ys5: "abc"
    zs1: takeWhile func [x][x < #"a"] xs
    zs2: takeWhile func [x][x < #"b"] xs
    zs3: takeWhile func [x][x < #"c"] xs
    zs4: takeWhile func [x][x < #"d"] xs
    zs5: takeWhile func [x][x < #"e"] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "dropWhile"

--test-- "(integer! -> logic!) -> [any-type!]"
    xs:  [1 2 3]
    ys1: []
    ys2: [1 2 3]
    ys3: [2 3]
    ys4: [3]
    ys5: []
    zs1: dropWhile :positive? xs
    zs2: dropWhile func[x][x < 1] xs
    zs3: dropWhile func[x][x < 2] xs
    zs4: dropWhile func[x][x < 3] xs
    zs5: dropWhile func[x][x < 4] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "integer! -> string! -> [string!]"
    xs:  "abc"
    ys1: "abc"   
    ys2: "bc"  
    ys3: "c" 
    ys4: ""
    ys5: ""
    zs1: dropWhile func [x][x < #"a"] xs
    zs2: dropWhile func [x][x < #"b"] xs
    zs3: dropWhile func [x][x < #"c"] xs
    zs4: dropWhile func [x][x < #"d"] xs
    zs5: dropWhile func [x][x < #"e"] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "dropWhileEnd"

--test-- "(integer! -> logic!) -> [any-type!]"
    xs:  [1 2 3]
    ys1: []
    ys2: [1 2 3]
    ys3: [1 2 3]
    ys4: [1 2 3]
    ys5: []
    zs1: dropWhileEnd :positive? xs
    zs2: dropWhileEnd func [x][x < 1] xs
    zs3: dropWhileEnd func [x][x < 2] xs
    zs4: dropWhileEnd func [x][x < 3] xs
    zs5: dropWhileEnd func [x][x < 4] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "integer! -> string! -> [string!]"
    xs:  "abc"
    ys1: "abc"   
    ys2: "abc"  
    ys3: "abc" 
    ys4: ""
    ys5: ""
    zs1: dropWhileEnd func [x][x < #"a"] xs
    zs2: dropWhileEnd func [x][x < #"b"] xs
    zs3: dropWhileEnd func [x][x < #"c"] xs
    zs4: dropWhileEnd func [x][x < #"d"] xs
    zs5: dropWhileEnd func [x][x < #"e"] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "span"

--test-- "(integer! -> logic!) -> [[integer!]"
    xs:  [1 2 3]
    ys1: [[1 2 3] []]
    ys2: [[] [1 2 3]]
    ys3: [[1] [2 3]]
    ys4: [[1 2] [3]]
    ys5: [[1 2 3] []]
    zs1: span :positive? xs
    zs2: span func [x][x < 1] xs
    zs3: span func [x][x < 2] xs
    zs4: span func [x][x < 3] xs
    zs5: span func [x][x < 4] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "string! -> string! -> [[string!]]"
    xs:  "abc"
    ys1: ["" "abc"]
    ys2: ["a" "bc"]
    ys3: ["ab" "c"]
    ys4: ["abc" ""]
    ys5: ["abc" ""]
    zs1: span func [x][x < #"a"] xs
    zs2: span func [x][x < #"b"] xs
    zs3: span func [x][x < #"c"] xs
    zs4: span func [x][x < #"d"] xs
    zs5: span func [x][x < #"e"] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "break'"

--test-- "(integer! -> logic!) -> [integer!] -> [[integer!]"
    xs:  [1 2 3]
    ys1: [[] [1 2 3]]
    ys2: [[1] [2 3]]
    ys3: [[1 2] [3]]
    ys4: [[1 2 3] []]
    ys5: [[1 2 3] []]
    zs1: break' :positive? xs
    zs2: break' func [x][x > 1] xs
    zs3: break' func [x][x > 2] xs
    zs4: break' func [x][x > 3] xs
    zs5: break' func [x][x > 4] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "(char! -> logic!) -> string! -> [[string!]]"
    xs:  "abc"
    ys1: ["" "abc"]
    ys2: ["a" "bc"]
    ys3: ["ab" "c"]
    ys4: ["abc" ""]
    ys5: ["abc" ""]
    zs1: break' func [x][x >= #"a"] xs
    zs2: break' func [x][x >= #"b"] xs
    zs3: break' func [x][x >= #"c"] xs
    zs4: break' func [x][x >= #"d"] xs
    zs5: break' func [x][x >= #"e"] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "stripPrefix"

--test-- "[integer!] -> [integer!] -> [integer!]"
    xs:  [1 2 3]
    ys1: [1 2 3]
    ys2: [2 3]
    ys3: [3]
    ys4: []
    ys5: Nothing
    zs1: stripPrefix [] xs
    zs2: stripPrefix [1] xs
    zs3: stripPrefix [1 2] xs
    zs4: stripPrefix [1 2 3] xs
    zs5: stripPrefix [1 2 3 4] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "string! -> string! -> [[string!]]"
    xs:  "abc"
    ys1: "abc"
    ys2: "bc"
    ys3: "c"
    ys4: ""
    ys5: Nothing
    zs1: stripPrefix "" xs
    zs2: stripPrefix "a" xs
    zs3: stripPrefix "ab" xs
    zs4: stripPrefix "abc" xs
    zs5: stripPrefix "abcd" xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "group"

--test-- "[integer!] -> [[integer!]"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3 3 2]
    xs5: [1 1 2 1]
    ys1: []
    ys2: [[1]]
    ys3: [[1] [2]]
    ys4: [[1] [2] [3 3] [2]]
    ys5: [[1 1] [2] [1]]
     zs1: group xs1
    zs2: group xs2
    zs3: group xs3
    zs4: group xs4
    zs5: group xs5
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "abc"
    xs3: "abba"
    xs4: "abcdd"
    xs5: "aabcdd"
    ys1: []
    ys2: ["a" "b" "c"]
    ys3: ["a" "bb" "a"]
    ys4: ["a" "b" "c" "dd"]
    ys5: ["aa" "b" "c" "dd"]
    zs1: group xs1
    zs2: group xs2
    zs3: group xs3
    zs4: group xs4
    zs5: group xs5
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===

===start-group=== "inits"

--test-- "[integer!] -> [[integer!]"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: [[]]
    ys2: [[] [1]]
    ys3: [[] [1] [1 2]]
    ys4: [[] [1] [1 2] [1 2 3]]
    zs1: inits xs1
    zs2: inits xs2
    zs3: inits xs3
    zs4: inits xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "a"
    xs3: "ab"
    xs4: "abc"
    ys1: [""]
    ys2: ["" "a"]
    ys3: ["" "a" "ab"]
    ys4: ["" "a" "ab" "abc"]
    zs1: inits xs1
    zs2: inits xs2
    zs3: inits xs3
    zs4: inits xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

===end-group===

===start-group=== "tails"

--test-- "[integer!] -> [[integer!]"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: [[]]
    ys2: [[1] []]
    ys3: [[1 2] [2] []]
    ys4: [[1 2 3] [2 3] [3] []]
    zs1: tails xs1
    zs2: tails xs2
    zs3: tails xs3
    zs4: tails xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "a"
    xs3: "ab"
    xs4: "abc"
    ys1: [""]
    ys2: ["a" ""]
    ys3: ["ab" "b" ""]
    ys4: ["abc" "bc" "c" ""]
    zs1: tails xs1
    zs2: tails xs2
    zs3: tails xs3
    zs4: tails xs4
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

===end-group===

;Predicates
===start-group=== "isPrefixOf"

--test-- "[integer!] -> [integer!] -> logic!"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: true
    ys2: true
    ys3: true
    ys4: false
    zs1: isPrefixOf xs1 [1 2 3]
    zs2: isPrefixOf xs2 [1 2 3]
    zs3: isPrefixOf xs3 [1 2 3]
    zs4: isPrefixOf xs4 [1 2]
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "a"
    xs3: "ab"
    xs4: "abc"
    ys1: true 
    ys2: true
    ys3: true
    ys4: false
    zs1: isPrefixOf xs1 "abc"
    zs2: isPrefixOf xs2 "abc"
    zs3: isPrefixOf xs3 "ab"
    zs4: isPrefixOf xs4 "ab"
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

===end-group===

===start-group=== "isSuffixOf"

--test-- "[integer!] -> [integer!] -> logic!"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: true
    ys2: false
    ys3: false
    ys4: false
    zs1: isSuffixOf xs1 [1 2 3]
    zs2: isSuffixOf xs2 [1 2 3]
    zs3: isSuffixOf xs3 [1 2 3]
    zs4: isSuffixOf xs4 [1 2]
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "a"
    xs3: "ab"
    xs4: "abc"
    ys1: true 
    ys2: false
    ys3: true
    ys4: false
    zs1: isSuffixOf xs1 "abc"
    zs2: isSuffixOf xs2 "abc"
    zs3: isSuffixOf xs3 "ab"
    zs4: isSuffixOf xs4 "ab"
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

===end-group===

===start-group=== "isInfixOf"

--test-- "[integer!] -> [integer!] -> logic!"
    xs1: []
    xs2: [1]
    xs3: [1 2]
    xs4: [1 2 3]
    ys1: true
    ys2: true
    ys3: true 
    ys4: false
    zs1: isInfixOf xs1 [1 2 3]
    zs2: isInfixOf xs2 [1 2 3]
    zs3: isInfixOf xs3 [1 2 3]
    zs4: isInfixOf xs4 [1 2 4]
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "a"
    xs3: "ab"
    xs4: "abc"
    ys1: true 
    ys2: true
    ys3: true
    ys4: false
    zs1: isInfixOf xs1 "abc"
    zs2: isInfixOf xs2 "abc"
    zs3: isInfixOf xs3 "ab"
    zs4: isInfixOf xs4 "abd"
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]

===end-group===

===start-group=== "isSubsequenceOf"

--test-- "[integer!] -> [integer!] -> logic!"
    xs1: []
    xs2: [1]
    xs3: [1 2 4]
    xs4: [1 2 5]
    xs4: [1 2 7]
    ys1: true
    ys2: true
    ys3: true 
    ys4: false
    zs1: isSubsequenceOf xs1 [1 2 3]
    zs2: isSubsequenceOf xs2 [1 2 3]
    zs3: isSubsequenceOf xs3 [1 2 3 4]
    zs4: isSubsequenceOf xs4 [1 2 3 4 5]
    zs5: isSubsequenceOf xs5 [1 2 3 4 5]
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys4 == zs5]

--test-- "string! -> [string!]"
    xs1: ""
    xs2: "a"
    xs3: "ab"
    xs4: "abc"
    xs4: "abcd"
    xs5: "abc"
    ys1: true 
    ys2: true
    ys3: true
    ys4: false
    ys5: true
    zs1: isSubsequenceOf xs1 "abc"
    zs2: isSubsequenceOf xs2 "abc"
    zs3: isSubsequenceOf xs3 "a b c"
    zs4: isSubsequenceOf xs4 "abd"
    zs5: isSubsequenceOf xs5 "ab cd"
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]
    --assert* [ys3 == zs3]
    --assert* [ys4 == zs4]
    --assert* [ys5 == zs5]

===end-group===


===start-group=== "sortBy"

--test-- "(integer! -> integer! -> logic!) -> [integer!] -> [integer!]"
    xs:  [1 2 3]
    ys1: [1 2 3]
    ys2: [3 2 1]
    zs1: sortBy (func [x y][x < y]) (copy xs)
    zs2: sortBy (func [x y][x > y]) (copy xs)
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "(char! -> char! -> logic!) -> string! -> string!"
    xs:  "abc"
    ys1: "abc"
    ys2: "cba"
    zs1: sortBy func [x y][x < y] xs
    zs2: sortBy func [x y][x > y] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

===end-group===

===start-group=== "insertBy"

--test-- "(integer! -> integer -> logic!) -> [integer!] -> [integer!]"
    xs:  [1 2 3]
    ys1: [1 2 3]
    ys2: [3 2 1]
    zs1: sortBy (func [x y][x < y]) (copy xs)
    zs2: sortBy (func [x y][x > y]) (copy xs)
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

--test-- "string! -> string! -> [[string!]]"
    xs:  "abc"
    ys1: "abc"
    ys2: "cba"
    zs1: sortBy func [x y][x < y] xs
    zs2: sortBy func [x y][x > y] xs
    --assert* [ys1 == zs1]
    --assert* [ys2 == zs2]

===end-group===

~~~end-file~~~
