## -*- mode: Awk; -*-  vim: set filetype=awk : 

#slurp

#Synopsis
#========

#  slurp(commmand,array  [,sep])

#Grab the output of a shell _command_ into an _array_, divided by a
#_seperator_ (defaults to newline).

#For very big files, _slurp_ is _not_ recommended. When dealing with
#very big files, it is  better to read each line one at a time.

#Code
#====

#Uses
#----

#@uses deShell

#Main
#----

 function slurp(com,all, sep) { 
     return split(slurp2String(com),
		  all, 
		  (sep ? sep : "\n")) 
 }
 function slurp2String(com,    txt,filename,fnr,nf,nr,rs,fs ) {
     filename=FILENAME;fnr=FNR;nf=NF;nr=NR;rs=RS;fs=FS;
     RS="\r\r\n"; FS="\r\r\n"; # change globals 
     com = deShell(com)        # make 'com0' safe
     com | getline txt ;       # everything is in 'txt'
     close(com);               # close pipe
     FILENAME=filename;FNR=fnr;NF=nf;NR=nr;RS=rs;FS=fs;
     return txt                # the end
 }

#Author
#======

#Tim Menzies

