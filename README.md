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

# Test
```./run-test```

<img width="401" alt="screen shot 2017-10-30 at 14 24 10" src="https://user-images.githubusercontent.com/4646838/32173165-578a69f8-bd7e-11e7-9267-f8ce070cedd9.png">
