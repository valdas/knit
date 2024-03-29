## -*- mode: Awk; -*-  vim: set filetype=awk : 

#stack

#Stack functions in Awk. 

#Simple stacks
#=============

#push
#----

#Push an _item_ into a stack "_s_". Return the size of the new stack.

 function push(s,item,  i) {      
     i    = ++s[0]
     s[i] = item
     return i
 }

#pop
#---

#Pop an _item_ from a stack "_s_". Return the _item_.

 function pop(s, i,item) { 
     i    = s[0]--
     item = s[i]
     delete s[i]
     return item
 }

#Cards (2-d stacks)
#===================

#Cards are a 2-d stack where item "_i_" in a set of cards _c_ has cardinality _c\[i,0\]_ 
#and card _c\[i,1\]_ , _c\[i,2\]_ , _c\[i,3\]_ ... 

#push2
#-----

#Push an _item_ into cards  "_c_" at a certain "_key_". Return the size of the new stack.

 function push2(c,key,item,   i)  {
     i = ++c[key,0]
     c[key,i] = item
     return i 
 }

#cards
#-----

#Return the number of cards at a particular _key_.

 function cards(c,key) { 
     return c[key,0] 
 }

#card
#----

#Return the _n_-th card at position _key_ in "_c_".

 function card(c,key,n) { 
     return c[key,n] 
 }

#Author
#======

#by Tim Menzies

