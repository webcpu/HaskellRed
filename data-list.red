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

block-subsequences: function [
    xs
][
    either (empty? xs) [
        copy [[]]
    ][
        append (copy [[]]) non-empty-block-subsequences xs
    ]
]

non-empty-block-subsequences: function [
    xs
][
    either empty? xs [copy []][non-empty-block-subsequences* xs]
]

non-empty-block-subsequences*: function [
    xs
][
    g: function [ys r][
        m1: reduce [ys] 
        m2: reduce [(reduce [first xs]) ++ ys]
        m3: r
        (m1 ++ m2) ++ m3
    ]

    r0: (reduce [reduce [first xs]])
    r1: foldr :g [] (non-empty-block-subsequences (rest xs))
    
    r0 ++ r1
]

string-subsequences: function [
    xs
][
    either (empty? xs) [
        copy [""]
    ][
        non-empty-string-subsequences xs
    ]
]

non-empty-string-subsequences: function [
    xs
][
    either empty? xs [copy []][non-empty-string-subsequences* xs]
]

non-empty-string-subsequences*: function [
    xs
][
    g: function [ys r][
        m1: reduce [ys] 
        m2: reduce [(to-string first xs) ++ ys]
        m3: r
        (m1 ++ m2) ++ m3
    ]

    r0: (reduce [to-string first xs])
    r1: foldr :g [] (non-empty-string-subsequences (rest xs))
    
    r0 ++ r1
]

permutations: function [
    "returns the list of all permutations of the argument." 
    xs
][
    case [
        (not series? xs) none
        (empty? xs) (reduce [xs])
        (block? xs) (block-permutations xs)
        (string? xs) (string-permutations xs)
    ]
]

block-permutations: function [
    xs
][
    either empty? xs [
        copy [[]] ; Don't use []
    ][
        ys: block-permutations (rest xs)
        f: func [zs][block-between (first xs) zs]
        g: func [zs x][zs ++ x]
        foldl :g [] (map :f ys)
    ]
]

block-between: function [
    x
    ys
][
    either (empty? ys) [reduce [reduce [x]]][block-between* x ys]
]

block-between*: function [
    x
    ys
][
    m1: (reduce [(reduce [x]) ++ ys])

    f: func [y][reduce [first ys] ++ y] 
    zs: block-between x (rest ys)
    m2: map :f zs
    m1 ++ m2
]

string-permutations: function [
    xs
][
    either empty? xs [
        copy [""] ; Don't use []
    ][
        ys: block-permutations (rest xs)
        f: func [zs][string-between (first xs) zs]
        g: func [zs x][zs ++ x]
        foldl :g [] (map :f ys)
    ]
]

string-between: function [
    x
    ys
][
    either (empty? ys) [reduce [to-string x]][string-between* x ys]
]

string-between*: function [
    x
    ys
][
    m1: (reduce [(to-string x) ++ ys])

    f: func [y][(to-string (first ys)) ++ y] 
    zs: string-between x (rest ys)
    m2: map :f zs
    m1 ++ m2
]

foldl: function [
    "reduces the list using the binary operator, from left to right"
    f
    y
    xs
][
    either empty? xs [y][
        r: y
        foreach x xs [r: f r x]
        r
    ]
]

"(a -> a -> a) -> [a] -> a"
foldl1: function [
    "A variant of foldl that has no base case, and thus may only be applied to non-empty structures."
    f
    xs
][
    either empty? xs [none][foldl :f (first xs) (rest xs)]
]

foldr: function [
    "reduces the list using the binary operator, from right to left"
    g
    y
    xs
][
    either empty? xs [
        y
    ][
        r: y
        foreach x (reverse xs) [r: g x r]
        r
    ]
]

;"(a -> a -> a) -> [a] -> a"
foldr1: function [
    "A variant of foldr that has no base case, and thus may only be applied to non-empty structures."
    f
    xs
][
    either empty? xs [none][foldr :f (last xs) (most xs)]
]

concat: function [
    "The concatenation of all the elements of a container of lists."
    xs
][
    either (all map :string? xs) [
        string-concat xs
    ][
        block-concat xs
    ]
]

block-concat: function [
    xs
][
    f: func [y x][y ++ x]
    foldl :f [] xs
]

string-concat: function [
    xs
][
    f: func [y x][y ++ x]
    foldl1 :f xs
]

concatMap: function [
    "Map a function over all the elements of a container and concatenate the resulting lists."
    f
    xs
][
    either (all map :string? xs) [
        string-concatMap :f xs
    ][
        block-concatMap :f xs
    ]
]

string-concatMap: function [
    f
    xs
][
    concat (map :f xs)
]

block-concatMap: function [
    f
    xs
][
    concat (map :f xs)
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
