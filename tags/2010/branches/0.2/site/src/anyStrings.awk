## -*- mode: Awk; -*-  vim: set filetype=awk : 

#anyStrings

#Selects a string, at random from a set of strings.

#Synopsis
#========

#    anyStrings(string  [,skew,repeats,sep])

#Variables
#---------

#The function returns a _repeats_ number of paragraphs from _string_,
#seperated by _sep_.  If _skew_ is greater than one, then favor strings
#with higher probabilities.

#_string_ is a list of paragraphs, with a number on the first
#line. These numbers form a probability distribution.  For example:

#  6  
#  "Out of clutter, find simplicity"
#  -- Albert Einstein

#  3
#  "Simplicity is the ultimate sophistication."
#  -- Leonardo da Vinci

#  1
#  "Good design is as little design as possible."
#  -- Dieter Rams

#  1
#  "If it's stupid, and it works, it isn't stupid."
#  -- Murphy's laws of combat. 

#  1
#  "Perfection: when there is nothing left to take away."
#  -- Antoine de Saint-Exupery

#N strings are returned, biased by the first line numbers. So, in this
#example, the first quote appears half the time, the second appears a
#quarter of the time and the last appear at much lower frequencies.

#Example
#=======

#(KNIT programmers can run this example using _cd quill; make eg10_).

#In the example, the file `etc/tests/anyStrings.in` contains
#the string of quotes shown above.

#Input:

#  srand(1); 
#  RS=FS="\r\r\r"; 
#  getline String <"etc/tests/anyStrings.in"; 
#  N=10; 
#  while(N--) 
#      print "\n" anyStrings(String) 

#Output (note that the Einstein quote with the highest probability appears most often):

#  "Perfection: when there is nothing left to take away."
#  -- Antoine de Saint-Exupery

#  "Simplicity is the ultimate sophistication."
#  -- Leonardo da Vinci

#  "Out of clutter, find simplicity"
#  -- Albert Einstein

#  "Good design is as little design as possible."
#  -- Dieter Rams

#  "Simplicity is the ultimate sophistication."
#  -- Leonardo da Vinci

#  "Out of clutter, find simplicity"
#  -- Albert Einstein

#  "Good design is as little design as possible."
#  -- Dieter Rams

#  "Out of clutter, find simplicity"
#  -- Albert Einstein

#  "Out of clutter, find simplicity"
#  -- Albert Einstein

#  "Simplicity is the ultimate sophistication."
#  -- Leonardo da Vinci

#Code
#====

#Uses
#----

#@uses default bias trim a2s stack

#Main
#----

 function anyStrings(string,   skew,repeats,sep,             \
                     pmax, paras,para,lines,freq, thing,cdf,memo,out) {
     skew    = default(skew,    1)
     repeats = default(repeats, 1)
     sep     = default(sep,     "\n")
     pmax = split(string,paras,/\n\n/)     
     for(para=1; para<=pmax; para++) {
         lines[0]    = split(paras[para],lines,/\n/)       
         thing       = trim(a2s(lines,"\n",2))
         freq[thing] = lines[1] + 0
     }
     sampleCounts(freq,cdf,memo)
     while(repeats--) 
         push(out,  memo[pick(cdf,skew)])
     return a2s(out,sep)
 }

#Author
#======

#Tim Menzies

