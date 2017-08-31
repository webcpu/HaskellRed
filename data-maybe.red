Red [
    Title:   "Data.Maybe"
    Author:  "unchartedworks"
    File: 	 %data-maybe.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]


Nothing: [] -> [make object! [type: 'Nothing]]
Just: [x] -> [make object! [type: 'Just value: x]]

isJust: [
    "returns True iff its argument is of the form Just _"
    x [object!]
] -> [x/type == 'Just]

isNothing: [
    "returns True iff its argument is Nothing."
    x [object!]
] -> [x/type == 'Nothing]

fromJust: [
    "extracts the element out of a Just and throws an error if its argument is Nothing."
    x [object!]
] -> [x/value]

fromMaybe: [
    "takes a default value and and Maybe value. If the Maybe is Nothing, it returns the default values; otherwise, it returns the value contained in the Maybe."
    x
    m [object!]
] -> [
    case [
        (isNothing x) x
        (isJust x) (fromJust x)
    ]
]

sequencially-compose*: function [
    "Sequentially compose two actions, passing any value produced by the first as an argument to the second."
    x [object!]
    f [function!]
][
    either isJust x [f fromJust x][Nothing]
]

>>=: make op! :sequencially-compose*
