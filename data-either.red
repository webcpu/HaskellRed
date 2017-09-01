Red [
    Title:   "Data.Either"
    Author:  "unchartedworks"
    File: 	 %data-either.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

Left: [x] -> [make object! [type: 'Left value: x]]
Right: [x] -> [make object! [type: 'Right value: x]]

either': [
    "Case analysis for the Either type. If the value is Left a, apply the first function to a; if it is Right b, apply the second function to b."
    f [any-function!]
    g [any-function!]
    mx [object!]
] -> [
    case [
        (isLeft mx) (f fromLeft)
        (isRight mx) (f fromRight)
        otherwise (cause-error 'script 'invalid-arg [mx])
    ]
]

isLeft: [
    "Return True if the given value is a Left-value, False otherwise."
    x [object!]
] -> [x/type == 'Left]

isRight: [
    "Return True if the given value is a Right-value, False otherwise."
    x [object!]
] -> [x/type == 'Right]

fromLeft: [
    "Return the contents of a Left-value or a default value otherwise."
    mx [object!]
] -> [
    either (isLeft mx) [mx/value] [cause-error 'script 'invalid-arg [mx]]
]

fromRight: [
    "Return the contents of a Right-value or a default value otherwise."
    mx [object!]
] -> [
    either (isRight mx) [mx/value] [cause-error 'script 'invalid-arg [mx]]
]

partitionEithers: [
    "Partitions a list of Either into two lists. All the Left elements are extracted, in order, to the first component of the output. Similarly the Right elements are extracted to the second component of the output."
    mxs' [series!]
] -> [
    mxs: reduce mxs'
    xs: reduce [map :fromLeft (filter :isLeft mxs)]
    ys: reduce [map :fromRight (filter :isRight mxs)]
    reduce xs ++ ys
]