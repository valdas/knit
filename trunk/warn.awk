
 function warn(str) {
 	print str >> "/dev/stderr"
 	fflush("/dev/stderr")
 }

