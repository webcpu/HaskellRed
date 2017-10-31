Red [
    Title:   "playground"
    Author:  "unchartedworks"
    File: 	 %all-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %haskell.red

;data-list
print "DataList"
;map
print "map"
xs: [1 2 3]
ys: (map :to-string xs)
print ys

;filter
print "filter"
xs: [1 "2" 3 "4" 5 "6"]
ys: filter :integer? xs
print ys

;foldl
print "foldl"
xs: [1 2 3 4]
f: func [y x][x * y]
ys: foldl :f 1 xs
print ys
print ""

;data-char
print "DataChar"
print isControl #"t"
print ""

;data-function
print "DataFunction"
f1: func [x][x * 2]
f2: func [x][length? x]
f:  :f1 . :f2
print f "abc"
print ""

;prelude
print "Prelude"
f: [x] -> [x + 1]
print f 1
print ""

;maybe
print "Maybe"
hit:      [x] -> [Just (x + 8)]
stand:    [x] -> [either x > 21 [Nothing][Just x]]
win:      [x] -> [Just "$1000"]
showtime: [x] -> [Just ("You win " ++ x ++ "!")]

blackjack: [x [object!]] -> [x >>= :hit >>= :hit >>= :stand >>= :win >>= :showtime]
print blackjack Just 3
print ""

;either
print "Either"
print fromRight Right 3
print ""

;control-monad
print "Control-Monad"
isTestFile:       [x]  -> [(isSuffixOf "-test.red" (to-string x)) && (%all-test.red <> x) && (not (isPrefixOf ".#" (to-string x)))]
filterTestFiles:  [xs] -> [filter :isTestFile xs]

xs: %./ >>>= [read filterTestFiles]
print xs