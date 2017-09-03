Red [
    Title:   "all test script"
    Author:  "unchartedworks"
    File: 	 %all-test.red
    Tabs:	 4
    Rights:  "unchartedworks. All rights reserved."
    License: "MIT"
]

#include %haskell.red

isTestFile:       [x]  -> [(isSuffixOf "-test.red" (to-string x)) && (%all-test.red <> x) && (not (isPrefixOf ".#" (to-string x)))]
filterTestFiles:  [xs] -> [filter :isTestFile xs]
includeFile:      [x]  -> [#include x]
includeFiles:     [xs] -> [map :includeFile xs]

%./ >>>= [read filterTestFiles includeFiles]
