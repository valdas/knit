Replacing Substrings
--------------------

Problem
_______

You want to replace a substring with a different string. For example,
you want to obscure all but the last four digits of a credit card
number before printing it.

Solution
________
sub(regexp, replacement, target)
    The sub function alters the value of target. It searches this value, which should be a string, for the leftmost substring matched by the regular expression, regexp, extending this match as far as possible. Then the entire string is changed by replacing the matched text with replacement. The modified string becomes the new value of target. This function is peculiar because target is not simply used to compute a value, and not just any expression will do: it must be a variable, field or array reference, so that sub can store a modified value there. If this argument is omitted, then the default is to use and alter $0. For example:

    str = "water, water, everywhere"
    sub(/at/, "ith", str)

    sets str to "wither, water, everywhere", by replacing the leftmost, longest occurrence of `at' with `ith'. The sub function returns the number of substitutions made (either one or zero). If the special character `&' appears in replacement, it stands for the precise substring that was matched by regexp. (If the regexp can match more than one string, then this precise substring may vary.) For example:

    awk '{ sub(/candidate/, "& and his wife"); print }'

    changes the first occurrence of `candidate' to `candidate and his wife' on each input line. Here is another example:

    awk 'BEGIN {
            str = "daabaaa"
            sub(/a*/, "c&c", str)
            print str
    }'

    prints `dcaacbaaa'. This show how `&' can represent a non-constant string, and also illustrates the "leftmost, longest" rule. The effect of this special character (`&') can be turned off by putting a backslash before it in the string. As usual, to insert one backslash in the string, you must write two backslashes. Therefore, write `\\&' in a string constant to include a literal `&' in the replacement. For example, here is how to replace the first `|' on each line with an `&':

    awk '{ sub(/\|/, "\\&"); print }'

    Note: as mentioned above, the third argument to sub must be an lvalue. Some versions of awk allow the third argument to be an expression which is not an lvalue. In such a case, sub would still search for the pattern and return 0 or 1, but the result of the substitution (if any) would be thrown away because there is no place to put it. Such versions of awk accept expressions like this:

    sub(/USA/, "United States", "the USA and Canada")

    But that is considered erroneous in gawk. 
gsub(regexp, replacement, target)
    This is similar to the sub function, except gsub replaces all of the longest, leftmost, nonoverlapping matching substrings it can find. The `g' in gsub stands for "global," which means replace everywhere. For example:

    awk '{ gsub(/Britain/, "United Kingdom"); print }'

    replaces all occurrences of the string `Britain' with `United Kingdom' for all input records. The gsub function returns the number of substitutions made. If the variable to be searched and altered, target, is omitted, then the entire input record, $0, is used. As in sub, the characters `&' and `\' are special, and the third argument must be an lvalue. 
