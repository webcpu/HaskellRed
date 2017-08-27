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
    f [any-function!]
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
    f [any-function!]
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
    f [any-function!]
    xs [series!]
][
    either empty? xs [none][foldl :f (first xs) (rest xs)]
]

foldr: function [
    "reduces the list using the binary operator, from right to left"
    g [any-function!]
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
    f [any-function!]
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
    f [any-function!]
    xs [series!]
][
    either (string? xs) [
        string-concatMap :f xs
    ][
        block-concatMap :f xs
    ]
]

string-concatMap: function [
    f [any-function!]
    xs [string!]
][
    ys: (map :f xs)
    either (string? ys) [ys][concat ys]
]

block-concatMap: function [
    f [any-function!]
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
    f [any-function!]
    y
    xs [series!]
][
    either series? xs [scanl* :f y xs][none]
]

scanl*: function [
    "scanl is similar to foldl, but returns a list of successive reduced values from the left"
    f [any-function!]
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
    f [any-function!]
    xs [series!]
][
    either (all [(series? xs) (0 < length? xs)]) [scanl* :f (first xs) (rest xs)][none]
]

scanr: function [
    "scanr is similar to foldr, but returns a list of successive reduced values from the left"
    f' [any-function!]
    y
    xs [series!]
][
    f: func [x' y'][f' y' x']
    reverse (scanl :f y (reverse xs))
]

scanr1: function [
    "a variant of scanr that has no starting value argument"
    f' [any-function!]
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
    p [any-function!]
    xs [series!]
][
    either (empty? xs) [xs][takeWhile* :p xs]
]

takeWhile*: function [
    p [any-function!]
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
    p [any-function!]
    xs [series!]
][
    n: length? (takeWhile :p xs)
    drop n xs
]

dropWhileEnd: function [
    "returns the suffix remaining after takeWhile p xs"
    p [any-function!]
    xs [series!]
][
    reverse (dropWhile :p (reverse xs))
]

span: function [
    " applied to a predicate p and a list xs, returns a tuple where first element is longest prefix (possibly empty) of xs of elements that satisfy p and second element is the remainder of the list"
    p [any-function!]
    xs [series!]
][
    reduce [(takeWhile :p xs) (dropWhile :p xs)]
]

break': function [
    "applied to a predicate p and a list xs, returns a tuple where first element is longest prefix (possibly empty) of xs of elements that do not satisfy p and second element is the remainder of the list"
    p [any-function!]
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

;; Searching lists
;; Searching by equality
elem: function [
    "Does the element occur in the structure?"
    x 
    xs [series!]
][
    none <> (find xs x)
]

notElem: function [
    "notElem is the negation of elem."
    x 
    xs [series!]
][
    none == (find xs x)
]

lookup: function [
    "looks up a key in a association list (map)"
    key 
    m [map!]
][
    get 'm/:key
]

;;Searching with a predicate
find': function [
    "takes a predicate and a structure and returns the leftmost element of the structure matching the predicate, or Nothing if there is no such element."
    f  [any-function!] 
    xs [series!]
][
    either empty? xs [none][find'* :f xs]
]

find'*: function [
    f   [any-function!] 
    xs' [series!]
][
    xs: copy xs'
    found: false
    while [all [(not found) (not tail? xs)]][
        x: first xs
        found: f x
        xs: next xs
    ]
    either found [x][none]
]

filter: function [
    "applying a predicate f to xs"
    f [any-function!]
    xs [series!]
][
    yss: either string? xs [copy ""][copy []]
    g: func [ys x][either f x [append ys reduce [x]][ys]]
    zss: foldl :g yss xs
]

partition: function [
    "takes a predicate and a structure and returns the leftmost element of the structure matching the predicate, or Nothing if there is no such element."
    f  [any-function!] 
    xs [series!]
][
    reduce [(filter :f xs) (filter func[x][not f x] xs)]
]

;;Indexing lists
list-index*: function [
    "List index (subscript) operator, starting from 0."
    xs [series!]
    i [integer!]
][
   xs/(i + 1) 
]
!!: make op! :list-index*

elemIndex: function [
    "returns the index of the first element in the given list which is equal (by ==) to the query element, or Nothing if there is no such element."
    x
    xs [series!]
][
    ys: find/case xs x
    either (ys == none) [none][offset? xs ys]
]

elemIndices: function [
    "returning the indices of all elements equal to the query element, in ascending order."
    x
    xs [series!]
][
    ys: copy []
    len: length? xs
    i: 1
    while [i <= len][
        ys: either (x == xs/:i)[ys ++ (reduce [(i - 1)])][ys]
        i: i + 1
    ]
    return ys
]

findIndex: function [
    "takes a predicate and a list and returns the index of the first element in the list satisfying the predicate, or Nothing if there is no such element."
    f [any-function!]
    xs [series!]
][
    len: length? xs
    i: 1
    r: none
    while [i <= len][
        either (f xs/:i) == true [
            (r: (i - 1))
            break
        ][
            i: i + 1
        ]
    ]
    return r
]

findIndices: function [
    "extends findIndex, by returning the indices of all elements satisfying the predicate, in ascending order."
    f [any-function!]
    xs [series!]
][
    len: length? xs
    i: 1
    rs: []
    while [i <= len][
        rs: either (f xs/:i) == true [rs ++ (reduce [i - 1])][rs]
        i: i + 1
    ]
    return rs
]

;;Zipping and unzipping lists
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

zip3: function [
    "takes three lists and returns a list of triples, analogous to zip."
    xs [series!]
    ys [series!]
    zs [series!]
][
    zss: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs]))
    repeat i :len [
        xyz: reduce [xs/:i ys/:i zs/:i]
        zss: zss ++ (reduce [xyz])
    ]
    return zss
]

zip4: function [
    "takes four lists and returns a list of quadruples, analogous to zip."
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
][
    zss: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us]))
    repeat i :len [
        xyzu: reduce [xs/:i ys/:i zs/:i us/:i]
        zss: zss ++ (reduce [xyzu])
    ]
    return zss
]

zip5: function [
    "takes four lists and returns a list of five-tuples, analogous to zip."
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
    vs [series!]
][
    zss: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us vs]))
    repeat i :len [
        xyzuv: reduce [xs/:i ys/:i zs/:i us/:i vs/:i]
        zss: zss ++ (reduce [xyzuv])
    ]
    return zss
]

zip6: function [
    "takes four lists and returns a list of six-tuples, analogous to zip."
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
    vs [series!]
    ws [series!]
][
    zss: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us vs ws]))
    repeat i :len [
        xyzuvw: reduce [xs/:i ys/:i zs/:i us/:i vs/:i ws/:i]
        zss: zss ++ (reduce [xyzuvw])
    ]
    return zss
]

zip7: function [
    "takes four lists and returns a list of seven-tuples, analogous to zip."
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
    vs [series!]
    ws [series!]
    ts [series!]
][
    zss: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us vs ws ts]))
    repeat i :len [
        xyzuvwt: reduce [xs/:i ys/:i zs/:i us/:i vs/:i ws/:i ts/:i]
        zss: zss ++ (reduce [xyzuvwt])
    ]
    return zss
]

zipWith: function [
    "generalises zip by zipping with the function given as the first argument, instead of a tupling function."
    f [any-function!]
    xs [series!]
    ys [series!]
][
    rs: copy []
    len: minimum (reduce (map :length? reduce [xs ys]))
    repeat i :len [
        r: f xs/:i ys/:i
        rs: rs ++ (reduce [r])
    ]
    return either (all (map :char? rs)) [concat (map :to-string rs)][rs]
]

zipWith3: function [
    "takes a function which combines three elements, as well as three lists and returns a list of their point-wise combination, analogous to zipWith."
    f [any-function!]
    xs [series!]
    ys [series!]
    zs [series!]
][
    rs: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs]))
    repeat i :len [
        r: f xs/:i ys/:i zs/:i
        rs: rs ++ (reduce [r])
    ]
    return either (all (map :char? rs)) [concat (map :to-string rs)][rs]
]

zipWith4: function [
    "takes a function which combines three elements, as well as four lists and returns a list of their point-wise combination, analogous to zipWith."
    f [any-function!]
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
][
    rs: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us]))
    repeat i :len [
        r: f xs/:i ys/:i zs/:i us/:i
        rs: rs ++ (reduce [r])
    ]
    return either (all (map :char? rs)) [concat (map :to-string rs)][rs]
]

zipWith5: function [
    "takes a function which combines three elements, as well as five lists and returns a list of their point-wise combination, analogous to zipWith."
    f [any-function!]
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
    vs [series!]
][
    rs: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us vs]))
    repeat i :len [
        r: f xs/:i ys/:i zs/:i us/:i vs/:i
        rs: rs ++ (reduce [r])
    ]
    return either (all (map :char? rs)) [concat (map :to-string rs)][rs]
]

zipWith6: function [
    "takes a function which combines three elements, as well as six lists and returns a list of their point-wise combination, analogous to zipWith."
    f [any-function!]
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
    vs [series!]
    ws [series!]
][
    rs: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us vs ws]))
    repeat i :len [
        r: f xs/:i ys/:i zs/:i us/:i vs/:i ws/:i
        rs: rs ++ (reduce [r])
    ]
    return either (all (map :char? rs)) [concat (map :to-string rs)][rs]
]

zipWith7: function [
    "takes a function which combines three elements, as well as seven lists and returns a list of their point-wise combination, analogous to zipWith."
    f [any-function!]
    xs [series!]
    ys [series!]
    zs [series!]
    us [series!]
    vs [series!]
    ws [series!]
    ts [series!]
][
    rs: copy []
    len: minimum (reduce (map :length? reduce [xs ys zs us vs ws ts]))
    repeat i :len [
        r: f xs/:i ys/:i zs/:i us/:i vs/:i ws/:i ts/:i
        rs: rs ++ (reduce [r])
    ]
    return either (all (map :char? rs)) [concat (map :to-string rs)][rs]
]

unzippable?: function [
    xss [series!]
][
    either (empty? xss) [
        true
    ][
        ts: map :type? xss
        first
    ]
]

normalize-series: func [xs][either (all (map :char? xs)) [concat (map :to-string xs)][xs]]

unzip: function [
    "transforms a list of pairs into a list of first components and a list of second components."
    xss [series!]
][
    rs1: copy []
    rs2: copy []
    len: length? xss
    repeat i :len [
        rs1: rs1 ++ (reduce [xss/:i/1])
        rs2: rs2 ++ (reduce [xss/:i/2])
    ]
    return map :normalize-series (reduce [rs1 rs2])
]

unzip3: function [
    "takes a list of triples and returns three lists, analogous to unzip."
    xss [series!]
][
    rs1: copy []
    rs2: copy []
    rs3: copy []
    len: length? xss
    repeat i :len [
        rs1: rs1 ++ (reduce [xss/:i/1])
        rs2: rs2 ++ (reduce [xss/:i/2])
        rs3: rs3 ++ (reduce [xss/:i/3])
    ]
    return map :normalize-series (reduce [rs1 rs2 rs3])
]

unzip4: function [
    "takes a list of triples and returns four lists, analogous to unzip."
    xss [series!]
][
    rs1: copy []
    rs2: copy []
    rs3: copy []
    rs4: copy []
    len: length? xss
    repeat i :len [
        rs1: rs1 ++ (reduce [xss/:i/1])
        rs2: rs2 ++ (reduce [xss/:i/2])
        rs3: rs3 ++ (reduce [xss/:i/3])
        rs4: rs4 ++ (reduce [xss/:i/4])
    ]
    return map :normalize-series (reduce [rs1 rs2 rs3 rs4])
]

unzip5: function [
    "takes a list of triples and returns five lists, analogous to unzip."
    xss [series!]
][
    rs1: copy []
    rs2: copy []
    rs3: copy []
    rs4: copy []
    rs5: copy []
    len: length? xss
    repeat i :len [
        rs1: rs1 ++ (reduce [xss/:i/1])
        rs2: rs2 ++ (reduce [xss/:i/2])
        rs3: rs3 ++ (reduce [xss/:i/3])
        rs4: rs4 ++ (reduce [xss/:i/4])
        rs5: rs5 ++ (reduce [xss/:i/5])
    ]
    return map :normalize-series (reduce [rs1 rs2 rs3 rs4 rs5])
]

unzip6: function [
    "takes a list of triples and returns six lists, analogous to unzip."
    xss [series!]
][
    rs1: copy []
    rs2: copy []
    rs3: copy []
    rs4: copy []
    rs5: copy []
    rs6: copy []
    len: length? xss
    repeat i :len [
        rs1: rs1 ++ (reduce [xss/:i/1])
        rs2: rs2 ++ (reduce [xss/:i/2])
        rs3: rs3 ++ (reduce [xss/:i/3])
        rs4: rs4 ++ (reduce [xss/:i/4])
        rs5: rs5 ++ (reduce [xss/:i/5])
        rs6: rs6 ++ (reduce [xss/:i/6])
    ]
    return map :normalize-series (reduce [rs1 rs2 rs3 rs4 rs5 rs6])
]

unzip7: function [
    "takes a list of triples and returns seven lists, analogous to unzip."
    xss [series!]
][
    rs1: copy []
    rs2: copy []
    rs3: copy []
    rs4: copy []
    rs5: copy []
    rs6: copy []
    rs7: copy []
    len: length? xss
    repeat i :len [
        rs1: rs1 ++ (reduce [xss/:i/1])
        rs2: rs2 ++ (reduce [xss/:i/2])
        rs3: rs3 ++ (reduce [xss/:i/3])
        rs4: rs4 ++ (reduce [xss/:i/4])
        rs5: rs5 ++ (reduce [xss/:i/5])
        rs6: rs6 ++ (reduce [xss/:i/6])
        rs7: rs7 ++ (reduce [xss/:i/7])
    ]
    return map :normalize-series (reduce [rs1 rs2 rs3 rs4 rs5 rs6 rs7])
]

;;Special lists
;;Functions on strings
lines: function [
    xs [string!]
][
    "breaks a string up into a list of strings at newline characters. The resulting strings do not contain newlines."
    split xs "^(line)"
]

words: function [
    "breaks a string up into a list of words, which were delimited by white space."
    xs [string!]
][
    split (trim/lines xs) " "
]

unlines: function [
    "an inverse operation to lines. It joins lines, after appending a terminating newline to each."
    xss [series!]
][
    either none == (all (map :string? xss)) [
        none
    ][
        concat map func [xs][xs ++ "^(line)"] xss
    ]
]

unwords: function [
    "an inverse operation to words. It joins words with separating spaces."
    xss [series!]
][
    either none == (all (map :string? xss)) [
        none
    ][
        concat intersperse " " xss
    ]
]

;;"Set" operations
nub: function [
    "removes duplicate elements from a list. In particular, it keeps only the first occurrence of each element. (The name nub means `essence'.) It is a special case of nubBy, which allows the programmer to supply their own equality test."
    xs [series!]
][
    unique/case xs
]

delete': function [
    " removes the first occurrence of x from its list argument."
    x
    xs' [series!]
][
    xs: copy xs'
    rs: find/case xs x
    either rs == none [xs][head remove rs]
]

groupBy: function [
    "the non-overloaded version of group."
    f [any-function!]
    xs [series!]
][
    case [
        (empty? xs) (copy [])
        (1 == (length? xs)) (reduce [xs])
        true (groupBy* :f xs)
    ]
]

groupBy*: function [
    f [any-function!]
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
