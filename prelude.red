Red [
    Title:   "Prelude"
    Author:  "unchartedworks"
    File: 	 %prelude.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

and*: function [
    "Boolean and"
    x [logic!]
    y [logic!]
][
    either x == y [
        either x == true [true][false]
    ][
        false
    ]
]
&&: make op! :and*

or*: function [
    "Boolean or"
    x [logic!]
    y [logic!]
][
    either x == true [
        true
    ][
        either y == true [true][false]
    ]
]
||: make op! :or*

not': function [
    "Boolean not"
    x [logic!]
][
    either x == true [false][true]
]

otherwise: function [
    "otherwise is defined as the value True"
][
    true
]

fst: function [
    "Extract the first component of a pair."
    xs [pair! series!]
][
    case [
        (pair? xs) (first xs)
        ((series? xs) && (2 == (length? xs))) (first xs)
        otherwise (cause-error 'script 'invalid-arg [xs])
    ]
]

snd: function [
    "Extract the second component of a pair."
    xs [pair! series!]
][
    case [
        (pair? xs) (second xs)
        ((series? xs) && (2 == (length? xs))) (last xs)
        otherwise (cause-error 'script 'invalid-arg [xs])
    ]
]

; curry: function [
;     "curry converts an uncurried function to a curried function."
;     f [any-function!]
;     x
; ][
;     func [y] reduce [:f :x 'y]
; ]

; uncurry: function [
;     "curry converts an curried function to a uncurried function."
;     f [any-function!]
;     x
; ][
;     func [y] reduce [:f :x 'y]
; ]

;;Enum
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
    imin [number!]
    imax [number!]
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

;;Numbers
;;negate
abs: :absolute

signum: function [
    x [number!]
][
    case [
        (positive? x) 1
        (negative? x) -1
        otherwise 0
    ]
]

div: :divide
;;mod

divMod: function [
    "simultaneous div and mod"
    m [integer!]
    n [integer!]
][
    reduce [(divide m n) (mod m n)]
]

:toInteger :to-integer

;;Numeric
even: function [
    x
][
    either 0 == (mod x 2) [true][false]
]

odd: function [
    x
][
    either 1 == (mod x 2) [true][false]
]

;;Misc
until': function [
    "until p f yields the result of applying f until p holds."
    condition [any-function!]
    f [any-function!]
    x
][
    y: x
    until [
        y: f y
        condition y
    ]
    y 
]
