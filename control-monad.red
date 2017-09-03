Red [
    Title:   "Control.Monad"
    Author:  "unchartedworks"
    File: 	 %control-monad.red
    Tabs:	   4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

sequencially-compose*: function [
    "Sequentially compose two actions, passing any value produced by the first as an argument to the second."
    x [object! series!]
    f [function!]
][
    case [
        object? x (sequencially-compose-object* x :f)
        series? x (sequencially-compose-series* x :f)
    ]
]

sequencially-compose-object*: function [
    x [object!]
    f [any-function!]
][
    case [
        (isLeft x) x
        (isRight x) (f fromRight x)
        (isNothing x) Nothing
        (isJust x) (f fromJust x)
    ]
]

sequencially-compose-series*: function [
    xs [series!]
    f [any-function!]
][
    case [
        (empty? xs) xs
        (series? xs) (concatMap :f xs)
    ]
]


>>=: make op! :sequencially-compose*