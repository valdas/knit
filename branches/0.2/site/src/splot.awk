## -*- mode: Awk; -*-  vim: set filetype=awk : 

#splot

#A variant of `split`. Divides a list. Adds size of list to the first item.

 function splot(string,array,   sep) {
    array[0]= split(string,array, sep)
}

#by Tim Menzies

