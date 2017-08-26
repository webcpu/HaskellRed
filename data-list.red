Red [
    Title:   "Data.List"
    Author:  "unchartedworks"
    File: 	 %data-list.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

add*: :add
add-matrix: func [xs ys][manipulate-matrix :add* xs ys]
+: make op! :add-matrix

subtract*: :subtract
subtract-matrix: func [xs ys][manipulate-matrix :subtract* xs ys]
-: make op! :subtract-matrix

multiply*: :multiply
multiply-matrix: func [xs ys][manipulate-matrix :multiply* xs ys]
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
        equal-blocks? xs' ys' (map :arithmetic-func (zip xs' ys'))
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
    xs [series!]
][
    copy next xs
]

init: function [
    "Return all the elements of a list except the last one. The list must be non-empty."
    xs [series!]
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
    xs [series!]
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
    xs [series!]
][
    length? xs
]

map: function [
    "applying f to each element of xs"
    f [function! native!]
    xs [series!]
][
    yss: copy []
    g: function [ys x] [append ys reduce [f x]]
    zss: foldl :g yss xs
    either all [(string? xs) all (map :char? zss)] [
        foldl func[y x][y ++ (to-string x)] "" zss
    ][
        zss
    ]
]

;--reverse is defined in Red, use reverse instead.
reverse*: :reverse
reverse: function [
    xs [series!]
][
    reverse* copy xs
]

intersperse: function [
    "taking an element and a list and `intersperses' that element between the elements of the list."
    y
    xs [series!]
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
    xss [series!]
][
    case [
        (not transposable? xss) none
        empty? xss [copy []]
        (empty? first xss) (copy [])
        true (append (copy reduce [map :first xss]) (transpose map :rest xss))
    ]
]

transposable?: function [
    xss [series!]
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
    xss [series!]
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
    xs [series!]
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
    xs [string!]
][
    either (empty? xs) [
        copy [""]
    ][
        non-empty-string-subsequences xs
    ]
]

non-empty-string-subsequences: function [
    xs [string!]
][
    either empty? xs [copy []][non-empty-string-subsequences* xs]
]

non-empty-string-subsequences*: function [
    xs [string!]
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
    xs [series!]
][
    case [
        (not series? xs) none
        (empty? xs) (reduce [xs])
        (block? xs) (block-permutations xs)
        (string? xs) (string-permutations xs)
    ]
]

block-permutations: function [
    xs [series!]
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
    ys [series!]
][
    either (empty? ys) [reduce [reduce [x]]][block-between* x ys]
]

block-between*: function [
    x
    ys [series!]
][
    m1: (reduce [(reduce [x]) ++ ys])

    f: func [y][reduce [first ys] ++ y] 
    zs: block-between x (rest ys)
    m2: map :f zs
    m1 ++ m2
]

string-permutations: function [
    xs [string!]
][
    either empty? xs [
        copy [""] ; Don't use []
    ][
        ys: string-permutations (rest xs)
        f: func [zs][string-between (first xs) zs]
        g: func [zs x][zs ++ x]
        foldl :g [] (map :f ys)
    ]
]

string-between: function [
    x [char!]
    ys [string!]
][
    either (empty? ys) [reduce [to-string x]][string-between* x ys]
]

string-between*: function [
    x [char!]
    ys [string!]
][
    m1: (reduce [(to-string x) ++ ys])

    f: func [y][(to-string (first ys)) ++ y] 
    zs: string-between x (rest ys)
    m2: map :f zs
    m1 ++ m2
]

foldl: function [
    "reduces the list using the binary operator, from left to right"
    f [function! native!]
    y
    xs [series!]
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
    f [function! native!]
    xs [series!]
][
    either empty? xs [none][foldl :f (first xs) (rest xs)]
]

foldr: function [
    "reduces the list using the binary operator, from right to left"
    g [function! native!]
    y
    xs [series!]
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
    f [function! native!]
    xs [series!]
][
    either empty? xs [none][foldr :f (last xs) (most xs)]
]

concat: function [
    "The concatenation of all the elements of a container of lists."
    xs [series!]
][
    case [
        ([] == xs) (copy [])
        (all (map :string? xs)) (string-concat xs)
        (all (map :block? xs)) (block-concat xs)
        true none
    ]
]

block-concat: function [
    xs [series!]
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
    f [function! native!]
    xs [series!]
][
    either (string? xs) [
        string-concatMap :f xs
    ][
        block-concatMap :f xs
    ]
]

string-concatMap: function [
    f [function! native!]
    xs [string!]
][
    ys: (map :f xs)
    either (string? ys) [ys][concat ys]
]

block-concatMap: function [
    f [function! native!]
    xs [series!]
][
    concat (map :f xs)
]

sum: function [
    "computes the sum of the numbers of a structure."
    xs [series!]
][
    case [
        [] == (xs) 0
        (all [block? xs (map :number? xs)]) (foldl1 func [y x][x + y] xs)
        true none]
]

product: function [
    "computes the product of the numbers of a structure."
    xs [series!]
][
    case [
        [] == (xs) 1
        (all [block? xs (map :number? xs)]) (foldl1 func [y x][x * y] xs)
        true none]
]

maximum: function [
    "The largest element of a non-empty structure."
    xs [series!]
][
    case [
        [] == (xs) none
        (all [(series? xs) (all (map :number? xs))]) (foldl1 func[y x][either y > x [y][x]] xs)
        true none]
]

minimum: function [
    "The largest element of a non-empty structure."
    xs [series!]
][
    case [
        [] == (xs) none
        (all [(series? xs) (all (map :number? xs))]) (foldl1 func[y x][either y < x [y][x]] xs)
        true none]
]

scanl: function [
    "scanl is similar to foldl, but returns a list of successive reduced values from the left"
    f [function! native!]
    y
    xs [series!]
][
    either series? xs [scanl* :f y xs][none]
]

scanl*: function [
    "scanl is similar to foldl, but returns a list of successive reduced values from the left"
    f [function! native!]
    y
    xs [series!]
][
    either empty? xs [reduce [y]][
        ys: [y]
        r: y
        foreach x xs [
            r: f r x
            ys: ys ++ (either (char? r) [to-string r][reduce [r]])
        ]
        return ys 
    ]
]

scanl1: function [
    "a variant of scanl that has no starting value argument"
    f [function! native!]
    xs [series!]
][
    either (all [(series? xs) (0 < length? xs)]) [scanl* :f (first xs) (rest xs)][none]
]

scanr: function [
    "scanr is similar to foldr, but returns a list of successive reduced values from the left"
    f' [function! native!]
    y
    xs [series!]
][
    f: func [x' y'][f' y' x']
    reverse (scanl :f y (reverse xs))
]

scanr1: function [
    "a variant of scanr that has no starting value argument"
    f' [function! native!]
    xs [series!]
][
    f: func [y' x'][f' x' y']
    either (all [(series? xs) (0 < (length? xs))]) [
        reverse (scanl1 :f reverse xs)
    ][
        none
    ]
]

replicate: function [
    "replicate n x is a list of length n with x the value of every element."
    n [integer!]
    x
][
    xs: either (char? x) [""][copy []]
    ys: either (char? x) [to-string x][reduce [x]]
    i: 1
    while [i <= n][
        xs: xs ++ ys
        i: i + 1
    ]
    xs 
]

take': func [
    "applied to a list xs, returns the prefix of xs of length n, or xs itself if n > length? xs"
    n [integer!]
    xs [series!]
][
    case [
        (n > (length? xs)) xs
        (n <= 0) (either (string? xs) [""][[]])
        (n <= (length? xs)) (take* n xs)
    ]
]

take*: function [
    n [integer!]
    xs [series!]
][
    ys: either (string? xs) [""][copy []]
    i: 1
    while [
        i <= n
    ][
        ys: ys ++ (either (string? xs) [to-string (xs/:i)][reduce [xs/:i]])
        i: i + 1]
    ys
]

drop: function [
    "returns the suffix of xs after the first n elements, or [] if n > length? xs"
    n [integer!]
    xs [series!]
][
    case [
        (n <= 0) xs
        (n >= (length? xs)) (either (string? xs) [""][[]])
        true (drop* n xs)
    ]
]

drop*: function [
    n [integer!]
    xs [series!]
][
    ys: either (string? xs) [""][copy []]
    i: n + 1
    while [
        i <= (length? xs)
    ][
        ys: ys ++ (either (string? xs) [to-string (xs/:i)][reduce [xs/:i]])
        i: i + 1]
    ys
]

splitAt: function [
    "returns a tuple where first element is xs prefix of length n and second element is the remainder of the list"
    n [integer!]
    xs [series!]
][
    reduce [(take' n xs) (drop n xs)]
]

takeWhile: function [
    " applied to a predicate p and a list xs, returns the longest prefix (possibly empty) of xs of elements that satisfy p"
    p [function! native!]
    xs [series!]
][
    either (empty? xs) [xs][takeWhile* :p xs]
]

takeWhile*: function [
    p [function! native!]
    xs [series!]
][
    ys: either (string? xs) [""][copy []]
    len: length? xs
    i: 1
    while [
        all [(i <= len) (p (xs/:i))]
    ][
        x: xs/:i
        ys: ys ++ (either (char? x) [to-string x][reduce [x]])
        i: i + 1
    ]
    return ys
]

dropWhile: function [
    "returns the suffix remaining after takeWhile p xs"
    p [function! native!]
    xs [series!]
][
    n: length? (takeWhile :p xs)
    drop n xs
]

dropWhileEnd: function [
    "returns the suffix remaining after takeWhile p xs"
    p [function! native!]
    xs [series!]
][
    reverse (dropWhile :p (reverse xs))
]

span: function [
    " applied to a predicate p and a list xs, returns a tuple where first element is longest prefix (possibly empty) of xs of elements that satisfy p and second element is the remainder of the list"
    p [function! native!]
    xs [series!]
][
    reduce [(takeWhile :p xs) (dropWhile :p xs)]
]

break': function [
    "applied to a predicate p and a list xs, returns a tuple where first element is longest prefix (possibly empty) of xs of elements that do not satisfy p and second element is the remainder of the list"
    p [function! native!]
    xs [series!]
][
    span func [x][not p x] xs
]

stripPrefix: function [
    "drops the given prefix from a list. It returns Nothing if the list did not start with the prefix given, or Just the list after the prefix, if it does."
    xs [series!]
    ys [series!]
][
    either empty? xs [ys][stripPrefix* xs ys]
]

stripPrefix*: function [
    xs [series!]
    ys [series!]
][
    n: length? xs
    either xs == (take' n ys) [drop n ys][Nothing]
]

group: function [
    "takes a list and returns a list of lists such that the concatenation of the result is equal to the argument. Moreover, each sublist in the result contains only equal elements."
    xs [series!]
][
    groupBy func [y x][y == x] xs
]

inits: function [
    "returns all initial segments of the argument, shortest first."
    xs [series!]
][
    xss: either string? xs [[""]][[[]]]
    to-series: func [x][either (char? x) [to-string x][reduce [x]]]
    f: func [yss x][yss: yss ++ [(last yss) ++ (to-series x)]]
    foldl :f xss xs
]

tails: function [
    "returns all final segments of the argument, longest first."
    xs [series!]
][
    reverse (map :reverse (inits (reverse xs)))
]

isPrefixOf: function [
    " takes two lists and returns True iff the first list is a prefix of the second."
    xs [series!]
    ys [series!]
][
    n: length? xs
    xs == (take' n ys) 
]

isSuffixOf: function [
    "takes two lists and returns True iff the first list is a suffix of the second."
    xs [series!]
    ys [series!]
][
    n: length? xs
    (reverse xs) == (take' n (reverse ys))
]

isInfixOf: function [
    "takes two lists and returns True iff the first list is contained, wholly and intact, anywhere within the second."
    xs [series!]
    ys [series!]
][
    case [
        (empty? xs) true
        (none == (find ys xs)) false
        true true
    ]
]

isSubsequenceOf: function [
    "takes two lists and returns True if all the elements of the first list occur, in order, in the second. The elements do not have to occur consecutively."
    xs [series!]
    ys [series!]
][
    either (empty? xs) [true][isSubsequenceOf* xs ys]
]

isSubsequenceOf*: function [
    xs [series!]
    ys [series!]
][
    either (empty? xs) [
        return true
    ][
        zs: find ys (first xs)
        either zs == none [false][isSubsequenceOf* (rest xs) zs]
    ]
]

groupBy: function [
    "the non-overloaded version of group."
    f [function! native!]
    xs [series!]
][
    case [
        (empty? xs) (copy [])
        (1 == (length? xs)) (reduce [xs])
        true (groupBy* :f xs)
    ]
]

groupBy*: function [
    f [function! native!]
    xs' [series!]
][
    zss: copy []
    xs: copy xs'
    while [0 < (length? xs)][
        y: first xs
        ys: takeWhile (func [x][f :y x]) (rest xs)
        xs: drop (length? (copy ys)) (rest xs)
        ys': either (char? y) [to-string y][reduce [y]]
        yss: reduce [ys' ++ ys]
        zss: either (empty? ys) [zss ++ (reduce [ys'])][zss ++ yss]
    ]
    return zss
]

sortBy: function [
    "the non-overloaded version of sort."
    f [any-function!]
    xs [series!]
][
    either string? xs [
        string-sortBy :f xs
    ][
        sort/compare (copy xs) :f
    ]
]

string-sortBy: function [
    f [any-function!]
    xs [series!]
][
    concat (sort/compare (map :to-string xs) :f)
]

filter: function [
    "applying a predicate f to xs"
    f [function! native!]
    xs [series!]
][
    yss: copy []
    g: func [ys x][either f x [append ys reduce [x]][ys]]
    zss: foldl :g yss xs
    either string? xs [rejoin zss][zss]
]

zip: function [
    "takes two lists and returns a list of corresponding pairs. If one input list is short, excess elements of the longer list are discarded."
    xs [series!]
    ys [series!]
][
    zss: copy []
    len: min (length? xs) (length? ys)
    repeat i :len [
        xy: reduce [xs/:i ys/:i]
        zss: zss ++ (reduce [xy])
    ]
    return zss
]
