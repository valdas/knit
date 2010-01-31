## -*- mode: Awk; -*-  vim: set filetype=awk : 

#Hello World!  

#Download
#========

#[http://knit.googlecode.com/svn/tags/helloworld/0.1/helloworld Version 0.1]

#Introduction
#============

#In the all the world, there has never been a hello like 'hello
#world'.  First seen in the famous K&R book on 'C', it has introduced
#a billion people to their first program.

#Code
#====

#Requires
#--------

#@uses options prints

#Main 
#----

 BEGIN { if (!Test) main() }

 function main() {
     ok2go(Opt, 
	   "What=Hello World;Why=saying hi!;When=2010;Who=Tim Menzies;"	\
	   "To=world;Say=hello;i="); 
     if (! opt("i")) {
	 	print opt("Say") " " opt("To");
	 	exit 
	}
 }

#If running in interactive mode, print hello and a qualifier for
#every line of input.

 { print opt("Say") " " opt("To") ", you " $0 "." }

#Support
#-------

 function help() {
    about()
    prints(" ", "usage: helloworld [OPTIONS] [qualifiers]"," ",
       " -a          About",
	   " -i          Interactive mode. Prints hello, plus",
       "             one qualifier per line of input.",
	   " -To Who     Address the greeting to 'Who'",
	   " -Say What   Start the greeting with 'Say'",
	   " -c          Copyright",
	   " -h          Help");
 }

#Author
#======

#Tim Menzies

