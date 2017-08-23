Red [
    Title:   "Data.List"
    Author:  "unchartedworks"
    File: 	 %data-list.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

add*: :add
add-matrix: func[xs ys][manipulate-matrix :add* xs ys]
+: make op! :add-matrix

subtract*: :subtract
subtract-matrix: func[xs ys][manipulate-matrix :subtract* xs ys]
-: make op! :subtract-matrix

multiply*: :multiply
multiply-matrix: func[xs ys][manipulate-matrix :multiply* xs ys]
*: make op! :multiply-matrix

divide*: :divide
divide-matrix: func[xs ys][manipulate-matrix :divide* xs ys]
/: make op! :divide-matrix

manipulate-matrix: function [
    f
    xs
    ys
][
    arithmetic-func: func [xy][f first xy last xy]
    xs': reduce xs
    ys': reduce ys
    case [
        equal-blocks? xs' ys' (map :arithmetic-func zip xs' ys')
        inequal-blocks? xs' ys' (do [print (unequal-error-message xs' ys') none])
        true f xs ys
    ]

    ;inequal-blocks? (cause-error 'script 'not-related [xs ys])
]

reduce-deep: function [
    xs'
] [
    xs: reduce xs'
    case [
        (not block? xs) xs
        (all [block? xs empty? xs]) xs
        (all [block? xs not empty? xs]) map :reduce-deep xs
    ]
]

equal-blocks?: func [xs ys][all [(block? xs) (block? ys) ((length? xs) == (length? ys))]] 
inequal-blocks?: func [xs ys][all [(block? xs) (block? ys) ((length? xs) <> (length? ys))]]
unequal-error-message: func[xs ys]["Blocks of unequal length in " ++ (mold xs) ++ ", " ++ (mold ys) ++ " cannot be combined"]

plus-block: function [
    xs [block! string!]
    ys [block! string!]
][
    append copy reduce xs reduce ys    
]
++: make op! :plus-block

;--head is defined in Red, use first instead.
;--last is defined in Red, use last instead.
;--tail is defined in Red, use rest instead.
rest: function [
    "Extract the elements after the head of a list, which must be non-empty."
    xs [block! string!]][
    copy next xs
]

init: function [
    "Return all the elements of a list except the last one. The list must be non-empty."
    xs [block! string!]
][
    either 1 == length? xs [
        either string? xs [copy ""][copy []]
    ][
        copy/part xs ((length? xs) - 1)
    ]
]
most: :init

uncons: function [
    "Decompose a list into its first and rest. If the list is empty, returns Nothing. If the list is non-empty, returns Just (x, xs), where x is the head of the list and xs its tail."
    xs [block! string!]
][
    either 0 == length? xs [
        Nothing
    ][
        reduce [first xs (rest xs)] 
    ]
]

Nothing: none

length: function [
    "Returns the size/length of a finite structure as an Int. The default implementation is optimized for structures that are similar to cons-lists, because there is no general way to do better."
    xs [block! string!]][
    length? xs
]

foldl: function [
    "reduces the list using the binary operator, from left to right"
    f
    y
    xs
][
    either empty? xs [y][foreach x xs [f y x]]
]

foldr: function [
    "reduces the list using the binary operator, from right to left"
    g
    y
    xs
][
    either empty? xs [y][foreach x (reverse xs) [g x y]]
]

map: function [
    "applying f to each element of xs"
    f
    xs
][
    yss: copy []
    g: function [ys x] [append ys reduce [f x]]
    zss: foldl :g yss xs
    either string? xs [rejoin zss][zss]
]

;--reverse is defined in Red, use reverse instead.
reverse*: :reverse
reverse: function [
    xs
][
    reverse* copy xs
]

intersperse: function [
    "taking an element and a list and `intersperses' that element between the elements of the list."
    y
    xs
][
    either 1 >= length? xs [
        xs
    ][
        f: func [ys x][append ys reduce [x y]]
        append (foldl :f copy [] (most reduce xs)) reduce [last reduce xs]
    ]
]

transpose: function [
    "transposing the rows and columns of its argument."
    xss
][
    case [
        (not transposable? xss) none
        empty? xss [copy []]
        (empty? first xss) (copy [])
        true (append (copy reduce [map :first xss]) (transpose map :rest xss))
    ]
]

transposable?: function [
    xss
][
    case [
        (xss == []) true
        true == (all (map func [x][all [block? x empty? x]] xss)) true
        none == (all (map :block? xss)) false
        (transposable?* xss) true
        true false
    ]
]

transposable?*: function [
    xss
][
    general-length?: func [x][either (series? x) [length? x][none]]
    length-equal?: func [x][(general-length? x) == (general-length? first :xss)] 

    none <> all [
        (block? xss)
        all (map :block? xss)
        all (map :length-equal? xss)
    ]
]

subsequences: function [
    "returns the list of all subsequences of the argument"
    xs
][
    case [
        (not series? xs) none
        (empty? xs) (reduce [xs])
        (block? xs) (block-subsequences xs)
        (string? xs) ([""] ++ (string-subsequences xs))
    ]
]

string-subsequences: function [
    xs
][
    return reduce [xs]
]

block-subsequences: function [
    xs
][
    either (empty? xs) [
        [[]]
    ][
        append (copy [[]]) non-empty-block-subsequences xs
    ]
]

non-empty-block-subsequences: function [
    xs
][
    either empty? xs [[]][non-empty-block-subsequences* xs]
]

non-empty-block-subsequences*: function [
    xs
][
    g: function [ys r][
        print "m++++++++++++"
        m1: reduce [ys] 
        m2: reduce [(reduce [first xs]) ++ ys]
        m3: r
        print mold m1
        print mold m2
        print mold m3
        m: (copy m1) ++ m2 ++ m3
        print mold m
        print "m------------"
        m
    ]

    r0: (reduce [reduce [first xs]])
    print "+++++++++++++++++++"
    bs: reduce (non-empty-block-subsequences (rest xs))
    print "+block-sequences+"
    print mold bs
    print "-block-sequences-"
    r1: foldr :g [] bs
  
    print "r++++++++++++"
    print mold r0
    print mold r1
    print mold (append r0 r1)
    print "r------------"
    print "-------------------"
    append (copy r0) r1
]

filter: function [
    "applying a predicate f to xs"
    f
    xs
][
    yss: copy []
    g: func [ys x][either f x [append ys reduce [x]][ys]]
    zss: foldl :g yss xs
    either string? xs [rejoin zss][zss]
]

zip: function [
    "takes two lists and returns a list of corresponding pairs. If one input list is short, excess elements of the longer list are discarded."
    xs
    ys
][
    valid-parameters?: func [xs ys][all [(block? xs) or (string? ys) (block? xs) or (string? ys)]] 
    either valid-parameters? xs ys [zip* xs ys][return none]
]

zip*: function [
    xs
    ys
][
    zss: copy []
    len: min (length? xs) (length? ys)
    repeat i :len [append zss reduce [reduce [xs/:i ys/:i]]]
]
