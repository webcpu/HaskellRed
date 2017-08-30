Red [
    Title:   "HaskellRed"
    Author:  "unchartedworks"
    File: 	 %haskell.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

id: function [
    "Identity function"
    x
][
    :x
]

const: function [
    "a unary function which evaluates to x for all inputs."
    x
    y
][
    :x
]

compose-function*: function [
    f [any-function!]
    g [any-function!]
][
    func [x] reduce [:f :g 'x]
]
.: make op! :compose-function*

flip: function [
    f [any-function!]
    b
    a
][
    f a b
]

postfix: func [
    "a reverse application operator. This provides notational convenience."
    x f
][
    f x
]
&: make op! :postfix