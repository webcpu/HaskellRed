# HaskellRed

A functional library for Red programmers.

# Prerequisites
- Red 0.6.3

# Examples
## Data List
### map
```
xs: [1 2 3]
map :to-string xs
```

```
["1" "2" "3"]
```

### filter
```
xs: [1 "2" 3 "4" 5 "6"]
filter :integer? xs
```

```
[1 3 5]
```

### foldl
```
xs: [1 2 3 4]
f: func [y x][x * y]
foldl :f 1 xs
```

```
24
```

## Data Function
### Function Composition
```
f1: func [x][x * 2]
f2: func [x][length? x]
f:  :f1 . :f2
f "abc"
```
```
6
```

## Maybe
```
hit:      [x] -> [Just (x + 8)]
stand:    [x] -> [either x > 21 [Nothing][Just x]]
win:      [x] -> [Just "$1000"]
showtime: [x] -> [Just ("You win " ++ x ++ "!")]

blackjack: [x [object!]] -> [x >>= :hit >>= :hit >>= :stand >>= :win >>= :showtime]
blackjack Just 3
```

```
 Just "You win $1000!"
```

## Control Monad
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

For more documentation, please refer to Haskell documentation and the test cases of HaskellRed.

# Development
## Test
```./run-test```

<img width="401" alt="screen shot 2017-10-30 at 14 24 10" src="https://user-images.githubusercontent.com/4646838/32173165-578a69f8-bd7e-11e7-9267-f8ce070cedd9.png">
