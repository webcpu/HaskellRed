Red [
    Title:   "Prelude"
    Author:  "unchartedworks"
    File: 	 %prelude.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

succ: function [
    "the successor of a value. For numeric types, succ adds 1."
    x
][
    case [
        (number? x) (x + 1)
        (char? x) (to-char (1 + to-integer x))
        true "none"]
]

pred: function [
    "the predecessor of a value. For numeric types, pred subtracts 1."
    x
][
    case [
        (number? x) (x - 1)
        (char? x) (to-char ((to-integer x) - 1))
        true "none"]
]

range: function [
    "generates the list [imin ... imax]."
    imin imax
][
    either negative? (imax - imin) [copy []][range* imin imax]
]
range*: function [imin imax][
    xs: copy reduce [imin]
    len: imax - imin
    repeat i :len [
        xs: xs ++ reduce [imin + i]
    ]
    xs
]

enumFromTo: :range
