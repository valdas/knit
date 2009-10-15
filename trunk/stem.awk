Accessing Substrings
--------------------

You want to extract part of a string, starting at a particular place in the string. 
For example, you want to prune the extension of a file (the last four characters)
so (e.g.) _myfile.doc_ becomes _myfile_.

Solution
________

Use _substr(string, start, length)_ to select your substrings:

 function stem(string) {
	return substr(string, 1, (length(string) - 4))
 }

Discussion
__________

If the  last _length_ argument is not supplied, the _substr_ function runs to length of the string.
