Red [
    Title:   "Data.Maybe test script"
    Author:  "unchartedworks"
    File: 	 %data-maybe-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-list.red
#include %data-function.red
#include %prelude.red
#include %data-maybe.red

~~~start-file~~~ "data-maybe"

===start-group=== ">>="
hit:      [x] -> [Just (x + 8)]
stand:    [x] -> [either x > 21 [Nothing][Just x]]
win:      [x] -> [Just "$1000"]
showtime: [x] -> [Just ("You win " ++ x ++ "!")]

blackjack: [x [object!]] -> [x >>= :hit >>= :hit >>= :stand >>= :win >>= :showtime]

--test-- "Just integer! -> Just string!"
    y: Just "You win $1000!"
    z: blackjack Just 3
    --assert* [y == z]

--test-- "Just integer! -> Nothing"
    y: Nothing
    z: blackjack Just 8
    --assert* [y == z]
===end-group===
~~~end-file~~~