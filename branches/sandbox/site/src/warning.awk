## -*- mode: Awk; -*-  vim: set filetype=awk : 

#warning 

#Prints a  string to standard error.

 function warning(str) {
     print "# ERROR: " str   >> "/dev/stderr";
     fflush("/dev/stderr");
 }

