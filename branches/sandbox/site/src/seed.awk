## -*- mode: Awk; -*-  vim: set filetype=awk : 

#seed

#Intializes (or resets) the random number generator

 function seed() {
    srand(Seed ? Seed : 1)
 }

#by Tim Menzies

