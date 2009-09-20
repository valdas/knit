s2a
===

Synposis
--------

    s2a(string,array [,sep]) => arraySize

Problem
-------
When initializing an array, it is useful to have a succinct
specification of the array contents; e.g.

    a,about,h,help,u,usage

specifies an array whose keys are "a,h,u" and whose values are
"about,help,usage".

Solution
--------
Use the odd numbered entries as the keys and the even entries as
the values. Divide the _string_ on _sep_ (defaults to _FS_). Return
the number of keys in the array.

 function s2a(string,array,sep,   n,tmp,i) {
	sep = sep ? sep : FS        # set optional input
	n = split(string,tmp,sep)
	for(i=1; i<=n; i +=2 )
		array[tmp[i]] = tmp[i+1]
	return n
 }

Author
------
Tim Menzies
