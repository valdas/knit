## -*- mode: Awk; -*-  vim: set filetype=awk : 

#basename

#Return the basename of a path.

 function basename(path,  n,tmp) {
    n = split(path,tmp,/\//)
    return tmp[n]
 }

#by Tim Menzies

