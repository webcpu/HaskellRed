Red [
    Title:   "Data.Char test script"
    Author:  "unchartedworks"
    File: 	 %data-char-test.red
    Tabs:	   4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %quick-test/quick-test.red

#include %data-char.red

~~~start-file~~~ "data-char"
lowercaseLetters: "abcdefghijklmnopqrstuvwxyz"
uppercaseLetters: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
digits:           "0123456789"
octDigits:        "01234567"
hexDigits:        "0123456789ABCDEFabcdef"
punctuations:     "!^"#$%&'()*+,-./:;<=>?@[\]^^_`{|}~"

===start-group=== "isControl"
--test-- "char! -> logic! 1"
    y: false
    z: isControl #"a"
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: isControl #"^/"
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: true
    z: isControl #"^(esc)"
    --assert* [y == z]
===end-group===

===start-group=== "isSpace"
--test-- "char! -> logic! 1"
    y: false
    z: isSpace #"a"
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: isSpace space
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: true
    z: isSpace #"^(tab)"
    --assert* [y == z]
===end-group===

===start-group=== "isLower"
--test-- "char! -> logic! 1"
    y: false
    z: all' :isLower uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: all' :isLower lowercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "isUpper"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isUpper uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: false
    z: all' :isUpper lowercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "isAlpha"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isAlpha uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: all' :isAlpha lowercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isAlpha digits
    --assert* [y == z]
===end-group===

===start-group=== "isAlphaNum"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isAlphaNum uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: all' :isAlphaNum lowercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: true
    z: all' :isAlphaNum digits
    --assert* [y == z]

--test-- "char! -> logic! 4"
    y: false
    z: all' :isAlphaNum [#" " #"^\"]
    --assert* [y == z]
===end-group===

===start-group=== "isDigit"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isDigit digits
    --assert* [y == z]

 --test-- "char! -> logic! 2"
     y: false
     z: all' :isDigit lowercaseLetters
     --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isDigit uppercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "isOctDigit"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isOctDigit octDigits
    --assert* [y == z]

 --test-- "char! -> logic! 2"
     y: false
     z: all' :isOctDigit digits
     --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isOctDigit hexDigits
    --assert* [y == z]
===end-group===

===start-group=== "isHexDigit"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isHexDigit hexDigits
    --assert* [y == z]

 --test-- "char! -> logic! 2"
     y: false
     z: all' :isOctDigit lowercaseLetters
     --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isOctDigit uppercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "isLetter"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isLetter uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: all' :isLetter lowercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isLetter digits
    --assert* [y == z]
===end-group===

===start-group=== "isPunctuation"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isPunctuation punctuations
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: false
    z: all' :isPunctuation lowercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isPunctuation digits
    --assert* [y == z]
===end-group===

===start-group=== "isSeparator"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isSeparator [#" " #"^-" #"^M" #"^/" #"^K" #"^L"]
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: false
    z: all' :isPunctuation lowercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 3"
    y: false
    z: all' :isPunctuation digits
    --assert* [y == z]
===end-group===

===start-group=== "isAsciiLower"
--test-- "char! -> logic! 1"
    y: false
    z: all' :isAsciiLower uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: true
    z: all' :isAsciiLower lowercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "isAsciiUpper"
--test-- "char! -> logic! 1"
    y: true
    z: all' :isAsciiUpper uppercaseLetters
    --assert* [y == z]

--test-- "char! -> logic! 2"
    y: false
    z: all' :isAsciiUpper lowercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "toUpper"
--test-- "char! -> char! 1"
    y: #"A"
    z: toUpper #"a"
    --assert* [y == z]

--test-- "char! -> char! 2"
    y: uppercaseLetters
    z: map :toUpper lowercaseLetters
    --assert* [y == z]

--test-- "string! -> string!"
    y: uppercaseLetters
    z: toUpper lowercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "toLower"
--test-- "char! -> char! 1"
    y: #"a"
    z: toLower #"A"
    --assert* [y == z]

--test-- "char! -> char! 2"
    y: lowercaseLetters
    z: map :toLower uppercaseLetters
    --assert* [y == z]

--test-- "string! -> string!"
    y: lowercaseLetters
    z: toLower uppercaseLetters
    --assert* [y == z]
===end-group===

===start-group=== "digitToInt"
--test-- "char! -> integer! 1"
    y: [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 10 11 12 13 14 15]
    z: map :digitToInt hexDigits
    --assert* [y == z]

--test-- "char! -> integer! 2"
    y: none
    z: attempt [digitToInt #"g"]
    --assert* [y == z]
===end-group===

===start-group=== "intToDigit"
--test-- "integer! -> char! 1"
    xs: [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 10 11 12 13 14 15] 
    ys: "0123456789abcdef"
    zs: map :intToDigit xs
    --assert* [y == z]

--test-- "integer! -> char! 1"
    y: none
    z: attempt [intToDigit 20]
    --assert* [y == z]
===end-group===

===start-group=== "ord"
--test-- "integer! -> char! 1"
    y: 97
    z: ord #"a"
    --assert* [y == z]

--test-- "integer! -> char! 1"
    y: 65
    z: ord #"A"
    --assert* [y == z]
===end-group===

===start-group=== "chr"
--test-- "integer! -> char! 1"
    y: #"a"
    z: chr 97
    --assert* [y == z]

--test-- "integer! -> char! 1"
    y: #"B"
    z: chr 66
    --assert* [y == z]
===end-group===
~~~end-file~~~