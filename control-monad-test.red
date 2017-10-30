Red [
    Title:   "Control.Monad test script"
    Author:  "unchartedworks"
    File: 	 %control-monad-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-function.red
#include %data-list.red
#include %prelude.red
#include %data-maybe.red
#include %data-either.red
#include %control-monad.red

~~~start-file~~~ "control-monad"

===start-group=== ">>="
hit:      [x] -> [Just (x + 8)]
stand:    [x] -> [either x > 21 [Nothing][Just x]]
win:      [x] -> [Just "$1000"]
showtime: [x] -> [Just ("You win " ++ x ++ "!")]

blackjack: [x [object!]] -> [x >>= :hit >>= :hit >>= :stand >>= :win >>= :showtime]

===start-group=== ">>="
;;List
--test-- "[integer!] -> [integer!] 1"
    y: [4]
    z: [3] >>= ([x] -> [reduce [x + 1]])
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 2"
    y: []
    z: [] >>= ([x] -> [reduce [x + 1]])
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 3"
    y: [3 4 5]
    z: [1 2 3] >>= ([x] -> [reduce [x + 1]]) >>= ([x] -> [reduce [x + 1]])
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 4"
    y: []
    z: [1 2 3] >>= ([x] -> [reduce [x + 1]]) >>= ([x] -> [[]])
    --assert* [y == z]

;;Maybe
--test-- "Just integer! -> Just string!"
    y: Just "You win $1000!"
    z: blackjack Just 3
    --assert* [y == z]

--test-- "Just integer! -> Nothing"
    y: Nothing
    z: blackjack Just 8
    --assert* [y == z]

;;Either
--test-- "Right integer! -> Left string! 1"
    f: [x] -> [either (x == 0) [Left "division by zero"][Right (x + 1)]]
    y: Left "division by zero"
    z: (Right 0) >>= :f
    --assert* [y == z]

--test-- "Right integer! -> Left string! 2"
    f: [x] -> [either (x == 0) [Left "error 1"][Right (x + 1)]]
    g: [x] -> [either (x > 8) [Left "error 2"][Right (x * 2)]]
    y: Left "error 2"
    z: (Right 8) >>= :f >>= :g
    --assert* [y == z]

--test-- "Right integer! -> Right integer! 1"
    f: [x] -> [either (x == 0) [Left "division by zero"][Right (x + 1)]]
    y: Right 4
    z: (Right 3) >>= :f
    --assert* [y == z]

--test-- "Right integer! -> Right integer! 2"
    f: [x] -> [either (x == 0) [Left "error 1"][Right (x + 1)]]
    g: [x] -> [either (x > 8) [Left "error 2"][Right (x * 2)]]
    y: Right 8
    z: (Right 3) >>= :f >>= :g
    --assert* [y == z]

--test-- "Left string! -> Left string!"
    f: [x] -> [either (x == 0) [Left "division by zero"][Right (x + 1)]]
    y: Left "division by zero"
    z: y >>= :f
    --assert* [y == z]
===end-group===

===start-group=== ">>"
;;List
--test-- "[integer!] -> [integer!] 1"
    y: [4]
    z: [3] >> [4]
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 2"
    y: []
    z: [] >> [4]
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 3"
    y: [3 4 5]
    z: [1 2 3] >> [3 4 5]
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 4"
    y: []
    z: [1 2 3] >> []
    --assert* [y == z]

;;Maybe
--test-- "Just integer! -> Nothing 1"
    y: Nothing
    z: (Just 0) >> Nothing
    --assert* [y == z]

--test-- "Just integer! -> Nothing 2"
    y: Nothing
    z: (Just 8) >> Nothing >> (Just 6)
    --assert* [y == z]

--test-- "Just integer! -> Just integer! 1"
    y: Just 4
    z: (Just 8) >> (Just 6) >> (Just 4)
    --assert* [y == z]

--test-- "Just integer! -> Just integer! 2"
    y: Just 2
    z: (Just 8) >> (Just 6) >> (Just 4) >> (Just 2)
    --assert* [y == z]

--test-- "Just integer! -> Just integer! 3"
    y: Nothing
    z: (Just 8) >> Nothing >> (Just 4) >> (Just 2)
    --assert* [y == z]

;;Either
--test-- "Right integer! -> Left string! 1"
    y: Left "division by zero"
    z: (Right 0) >> Left "division by zero"
    --assert* [y == z]

--test-- "Right integer! -> Left string! 2"
    y: Left "error 2"
    z: (Right 8) >> (Left "error 2") >> (Right 6)
    --assert* [y == z]

--test-- "Right integer! -> Right integer! 1"
    y: Right 4
    z: (Right 8) >> (Right 6) >> Right 4
    --assert* [y == z]

--test-- "Right integer! -> Right integer! 2"
    y: Right 2
    z: (Right 8) >> (Right 6) >> (Right 4) >> (Right 2)
    --assert* [y == z]

--test-- "Left string! -> Left string!"
    y: Left "division by zero"
    z: y >> Left "hello"
    --assert* [y == z]
===end-group===

===start-group=== "liftM"
;;List
--test-- "[integer!] -> [integer!] 1"
    f: [x] -> [x + 1]
    y: [5]
    z: liftM :f [4]
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 2"
    f: [x] -> [x + 1]
    y: []
    z: liftM :f []
    --assert* [y == z]

--test-- "[integer!] -> [integer!] 3"
    f: [x] -> [x + 1]
    y: [2 3 4]
    z: liftM :f [1 2 3]
    --assert* [y == z]

;;Maybe
--test-- "Just integer! -> Nothing 1"
    f: [x] -> [x + 1]
    y: Nothing
    z: liftM :f Nothing
    --assert* [y == z]

--test-- "Just integer! -> Nothing 2"
    f: [x] -> [x + 1]
    y: Just 9
    z: liftM :f (Just 8)
    --assert* [y == z]

;;Either
--test-- "Right integer! -> Left string! 1"
    f: [x] -> [x + 1]
    y: Left "division by zero"
    z: liftM :f Left "division by zero"
    --assert* [y == z]

--test-- "Right integer! -> Right integer! 1"
    f: [x] -> [x + 1]
    y: Right 9
    z: liftM :f (Right 8)
    --assert* [y == z]
===end-group===

===start-group=== "liftM2"
;List
 ; --test-- "[integer!] -> [integer!] 1"
 ;     f: [x y] -> [x + y]
 ;     y: [5]
 ;     z: liftM2 :f [1 2] [5]
 ;     --assert* [y == z]

; --test-- "[integer!] -> [integer!] 2"
;     f: [x] -> [x + 1]
;     y: []
;     z: liftM :f []
;     --assert* [y == z]

; --test-- "[integer!] -> [integer!] 3"
;     f: [x] -> [x + 1]
;     y: [2 3 4]
;     z: liftM :f [1 2 3]
;     --assert* [y == z]
===end-group===
~~~end-file~~~
