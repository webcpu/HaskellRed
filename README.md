# HaskellRed

A functional library for Red programmers.

# Examples
## Maybe
```
hit:      [x] -> [Just (x + 8)]
stand:    [x] -> [either x > 21 [Nothing][Just x]]
win:      [x] -> [Just "$1000"]
showtime: [x] -> [Just ("You win " ++ x ++ "!")]

blackjack: [x [object!]] -> [x >>= :hit >>= :hit >>= :stand >>= :win >>= :showtime]
blackjack Just 3

```

## Data List
```
Red [
    Title:   "all test script"
    Author:  "unchartedworks"
    File: 	 %all-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %haskell.red

isTestFile:       [x]  -> [(isSuffixOf "-test.red" (to-string x)) && (%all-test.red <> x) && (not (isPrefixOf ".#" (to-string x)))]
filterTestFiles:  [xs] -> [filter :isTestFile xs]
includeFile:      [x]  -> [#include x]
includeFiles:     [xs] -> [map :includeFile xs]

%./ >>>= [read filterTestFiles includeFiles]
```
