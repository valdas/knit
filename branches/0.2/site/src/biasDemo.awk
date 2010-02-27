## -*- mode: Awk; -*-  vim: set filetype=awk : 

#biasDemo

#This is a tutorial on using the [bias] code.

#(KNIT programmers can run this demo using _cd quill; make eg12_.)

#Uses Cases
#==========

#Sample from a list of things
#----------------------------

#Given a list of things, prepare the cdf and memos required to sample from that list.
#The _population_ array holds the "_n_"  inputs and _cdf_ and _memo_ are the output. The standard
#idiom for running this code is:

#    collect( pop )   
#    sample(pop,cdf,memo) # set up
#    while(repeats--)
#        use( memo[pick(cdf)] ) # use one item

#Sample from a pairs of symbols/frequencies
#------------------------------------------

#Given things a,b,c,... with frequency counts fa,fb,fc,... and an
#array of {thing/f}+ pairs, prepare the cdf and memos required
#to sample those symbols from those frequencies. The standard idiom for
#running this scenario is as follows:

#  collect( pairs ) # somehow, collect pairs of {thing/freq}+
#  sampleCounts(pairs,cdf,memo)
#  while(repeats--)
#      use( memo[pick(cdf)] )

#Sample from indexed frequencies
#-------------------------------

#Given  numeric indexes 1,2,3,... with frequencies, f1,f2,f3,... and an array
#of item/f pairs, prepare the cdf required to sample
#from that list.  The standard idiom for running this use case is as
#follows

#    collect( pairs )   # somehow, collect data
#    a2cdf(pairs,cdf) # set up
#    while(repeats--)
#        use( pick(cdf) ) # use one item 

#Code
#====

#Uses
#----

#@uses bias

#Demos
#-----

#These demos generate values from the same distribution. We pick at random from a space
#of four apples, three  bananas, two carrots and one durian. In the _numericBiasDemo_ 
#we already have those counts, while in the _discreateBiasDemo_ we compute them
#from a sample. 

 function demoBias() {
     srand(1)
     print "\n---| numericBiasDemo |--------"
     numericBiasDemo("1,3,2,4")
     print "\n---| biasPairsDemo |--------"
     pairsBiasDemo("durian,1,banana,3,carrot,2,apple,4")
     print "\n---| discreteBiasDemo |--------"
     discreteBiasDemo("apple,banana,carrot,durian,"\
                      "apple,banana,carrot,apple,banana,apple")
 }
 function pairsBiasDemo(data, n,pairs,i,all,cdf,count,memo,max,r,com){
     print data
     n= s2a(data,pairs,",")
     sampleCounts(pairs,cdf,memo)
     max=r=10000; 
     while(--r)
         count[memo[pick(cdf)]]++
     # reporting
     com = "sort -n"
     for(i in count)
         print i " " count[i] " (" round(100*count[i]/max) "%)" | com
     close(com)
 }
 function numericBiasDemo(frequencies,  \
                          n,a,cdf,max,r,i,count,com) {
     n=split(frequencies,a,",")
     #set up
     a2cdf(a,cdf)
     # generating
     max=r=10000; 
     while(--r)
         count[pick(cdf)]++
     # reporting
     com = "sort -n"
     for(i in count)
         print i " " count[i] " (" round(100*count[i]/max) "%)" | com
     close(com)
 }
 function discreteBiasDemo(things,    all,a,cdf,memo,max,r,i,com,count) {
     split(things,a,",")
     #set up 
     all = sample(a,cdf,memo)
     # digression: showing off some internals
     oo(cdf,"cdf")          
     oo(memo,"memo")
     # generating
     max=r=10000;  
     while(--r)
         count[memo[pick(cdf)]]++ # memo maps numbers to symbols
     # reporting
     com = "sort -n -k 2"
     for(i in count)
         print i" "count[i]" ("round(100*count[i]/max)"%)" | com
     close(com)     
 }

#Demo Output
#-----------

#(KNIT programmers can run this demo using _cd quill; make eg12_.)

#  ----| eg12 |--------------

#  ---| numericBiasDemo |--------
#  1 1026 (10%)
#  2 1960 (20%)
#  3 3027 (30%)
#  4 3986 (40%)

#  ---| biasPairsDemo |--------
#  durian,1,banana,3,carrot,2,apple,4
#  apple 4022 (40%)
#  banana 2976 (30%)
#  carrot 2032 (20%)
#  durian 969 (10%)

#  ---| discreteBiasDemo |--------
#  cdf[ 4 ]        =        [ 1 ]
#  cdf[ -1 ]       =        [ 100.003 ]
#  cdf[ -2 ]       =        [ 200.007 ]
#  cdf[ -3 ]       =        [ 300.009 ]
#  cdf[ -4 ]       =        [ 400.008 ]
#  cdf[ 0 ]        =        [ 4 ]
#  cdf[ 1 ]        =        [ 0.0999998 ]
#  cdf[ 2 ]        =        [ 0.300001 ]
#  cdf[ 3 ]        =        [ 0.600002 ]
#  memo[ 200.007 ] =        [ carrot ]
#  memo[ 400.008 ] =        [ apple ]
#  memo[ 300.009 ] =        [ banana ]
#  memo[ 100.003 ] =        [ durian ]
#  durian 1008 (10%)
#  carrot 1938 (19%)
#  banana 3086 (31%)
#  apple 3967 (40%)

#Author
#======

#Tim Menzies

