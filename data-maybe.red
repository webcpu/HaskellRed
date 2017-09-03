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

maybe: [
    " takes a default value, a function, and a Maybe value. If the Maybe value is Nothing, the function returns the default value. Otherwise, it applies the function to the value inside the Just and returns the result."
    y
    f
    mx [object!]
] -> [
    case [
        (isNothing mx) y
        (isJust mx) (f fromJust mx)
    ]
]

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
    y
    mx [object!]
] -> [
    case [
        (isNothing mx) y
        (isJust mx) (fromJust mx)
    ]
]

listToMaybe: [
    "The listToMaybe function returns Nothing on an empty list or Just a where a is the first element of the list."
    xs [series!]
] -> [
    either empty? xs [Nothing][Just first xs]
]

catMaybes: [
    "The maybeToList function returns an empty list when given Nothing or a singleton list when not given Nothing."
    mxs [series!]
] -> [
    xs: map :fromJust (filter :isJust reduce mxs)
    either (all' :char? xs) [copy rejoin xs][xs]
]

mapMaybes: [
    "The mapMaybe function is a version of map which can throw out elements. In particular, the functional argument returns something of type Maybe b. If this is Nothing, no element is added on to the result list. If it is Just b, then b is included in the result list."
    f [function!]
    xs [series!]
] -> [
    catMaybes map :f xs 
]
