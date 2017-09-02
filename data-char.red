Red [
    Title:   "Data.Char"
    Author:  "unchartedworks"
    File: 	 %data-char.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %prelude.red

isControl: function [
    "These characters are specifically the Unicode values U+0000 to U+001F and U+007F to U+009F."
    c [char!]
][
    n: (to-hex to-integer c)
    ((#00000000 <= n) && (n <= #0000001f)) || ((#0000007f <= n) && (n <= #0000009f))
]

isSpace: function [
    "a character set containing only the in-line whitespace characters space (U+0020) and tab (U+0009)."
    c [char!]
][
    (c == #" ") || (c == #"^-") || (c == #"^M") || (c == #"^/") || (c == #"^K") || (c == #"^L")
]

isLower: function [
    "a character set containing only the in-line lowercase characters."
    c [char!]
][
    (c <= #"z") && (c >= #"a")
]

isUpper: function [
    "a character set containing only the in-line uppercase characters."
    c [char!]
][
    (c <= #"Z") && (c >= #"A")
]

isAlpha: function [
    "a character set containing only the letter characters."
    c [char!]
][
    (isLower c) || (isUpper c)
]

isAlphaNum: function [
    "a character set containing only the letter and digit characters."
    c [char!]
][
    (isAlpha c) || (isDigit c)
]

isPrint: function [
    "a character set containing only the printable characters."
    c [char!]
][
    (isLower c) || (isUpper c)
]

isDigit: function [
    "a character set containing only the digit characters."
    c [char!]
][
    (c <= #"9") && (c >= #"0")
]

isOctDigit: function [
    "a character set containing only the oct digit characters."
    c [char!]
][
    (c <= #"7") && (c >= #"0")
]

isHexDigit: function [
    "a character set containing only the hex digit characters."
    c [char!]
][
    elem c "0123456789ABCDEFabcdef"
]

isLetter: function [
    "a character set containing only the letter characters."
    c [char!]
][
    isAlpha c
]

isPunctuation: function [
    "Selects Unicode punctuation characters, including various kinds of connectors, brackets and quotes. It's not finished yet."
    "This function returns True if its argument has one of the Category, or False otherwise"
    c [char!]
][
    punctuations: "!^"#$%&'()*+,-./:;<=>?@[\]^^_`{|}~"
    elem c punctuations
]

isSeparator: function [
    "This function returns True if its argument has one of Space, LineSeparator, ParagraphSeparator"
    c [char!]
][
     n: (to-hex to-integer c)
    (isSpace c) || (n == #00002028) || (n == #00002029)
]

isAscii: function [
    "Selects the first 128 characters of the Unicode character set, corresponding to the ASCII character set."
    c [char!]
][
    n: (to-hex to-integer c)
    c < #00000080
]

isLatin1: function [
    "Selects the first 256 characters of the Unicode character set, corresponding to the ASCII character set."
    c [char!]
][
    n: (to-hex to-integer c)
    c < #00000100
]

isAsciiLower: function [
    "a character set containing only the in-line lowercase characters."
    c [char!]
][
    (c <= #"z") && (c >= #"a")
]

isAsciiUpper: function [
    "a character set containing only the in-line uppercase characters."
    c [char!]
][
    (c <= #"Z") && (c >= #"A")
]

toUpper: function [
    "Convert a letter to the corresponding upper-case letter, if any. Any other character is returned unchanged."
    c' [char! string!]
][
    c: either (char? c') [c'][copy c']
    uppercase c
]

toLower: function [
    "Convert a letter to the corresponding lower-case letter, if any. Any other character is returned unchanged."
    c' [char! string!]
][
    c: either (char? c') [c'][copy c']
    lowercase c
]


digitToInt: function [
    "Convert a single digit Char to the corresponding Int. This function fails unless its argument satisfies isHexDigit, but recognises both upper- and lower-case hexadecimal digits (that is, '0'..'9', 'a'..'f', 'A'..'F')."
    c [char!]
][
    case [
        (isDigit c) ((to-integer c) - (to-integer #"0"))
        ((#"a" <= c) && (c <= #"f")) ((to-integer c) - (to-integer #"a") + 10)
        ((#"A" <= c) && (c <= #"F")) ((to-integer c) - (to-integer #"A") + 10)
        true (cause-error 'script 'invalid-arg [c])
    ]
]

intToDigit: function [
    "Convert an Int in the range 0..15 to the corresponding single digit Char. This function fails on other inputs, and generates lower-case hexadecimal digits."
    x [integer!]
][
    case [
        ((0 <= x) && (x <= 9))  (to-char (x + (to-integer #"0")))
        ((10 <= x) && (x < 16)) (to-char (x + (to-integer #"a")))
        true (cause-error 'script 'invalid-arg [x])
    ]
]

ord: :to-integer

chr: :to-char