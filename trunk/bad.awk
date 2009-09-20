bad
===

Synopsis
--------

    bad(string)

Problem
-------
You want to print an error message to standard error, then quit the program.

Solution
--------

 function bad(str) {
 	warn(str)
 	exit 1
 }

See Also
--------

@uses warn.awk

Author
------

Tim Menzies
