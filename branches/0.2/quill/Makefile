# -*- mode: Makefile; -*-  vim: set filetype=Makefile : 
#
# This file is part of KNIT; copyright (C) 2010 by Tim Menzies
# tim@menzies.us.
#
# KNIT is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# KNIT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with KNIT.  If not, see <http://www.gnu.org/licenses/>.

This    = quill#
Version = 0.1#

about: 
	@echo "A test engine for QUILL function $(This), v$(Version)"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

Files = $(subst quill.wak,,$(shell ls *.wak))

Waks = $(subst .wak,,$(Files))

builds 	: quill.wak quillHtml quillSave

quill.wak : $(Files)
	@echo "# -*- mode: Awk; -*-  vim: set filetype=awk :" > quill.wak
	@printf "\nThis is an auto-generated file. Do not edit.\n" >> quill.wak
	@printf "\n@uses" >> quill.wak
	@$(foreach i,$(Waks), echo -n " $i" >> quill.wak;)
	@printf "\n\n function demoQuill() { print \"This is Quill.\" }\n\n" >> quill.wak
	@$(MAKE) -s This=quill build

quillHtml : 
	@$(foreach i,$(Waks), $(MAKE) -q This=$i build; )

quillSave :
	@cd $(Lib); svn -q add *;
	@cd $(Old); svn  -q add *;
	@cd $(Html); svn  -q add *; svn commit -m "updating web site"

eg1 : quill.wak
	@$I; $a print default("123","456"), default("","789"), default(0,"0ab") $z

eg2 : quill.wak
	@$I; $a splot("a:b:c:d",A,":"); for(I=1;I<=A[0];I++) print I " " A[I] $z

eg3 : quill.wak
	@$I; $a S1="a:b:c:d"; \
            splot(S1,tmp,":"); \
            print S1 " -> " a2s(tmp, ",",2); $z;

eg09 : quill.wak
	@$a  for(I=1;I<=20;I++) print I " " factorial(I) $z

eg10 : quill.wak
	@$I; $a srand(1); \
		    RS=FS="\r\r\r"; \
			getline String <"etc/tests/anyStrings.in"; \
			N=10; \
			while(N--) \
			   print "\n" anyStrings(String)  \
		 $z

eg11 : quill.wak
	@$I; $a print basename("/hOME/timm/opt/bin/gawk");\
            print basename("gawk")   \
         $z

eg12 : quill.wak
	@$I; $(MAKE) u=biasDemo  demo

eg13: quill.wak
	@$I; $a  N=cat("etc/tests/eg13.in",All); \
                 o(All,"cat",N) $z

eg14: quill.wak
	@$I; $a s2a("What,gizmo,Why,A wonderful thing,When,2010,Who,Tim Menzies",Opt); \
                copyleft() $z

eg15: quill.wak
	@$I; $a S="Tim `rm -rf $$HOME/*` Menzies"; print S " ==> " deShell(S); $z

eg16: quill.wak
	@$I; $a for(I= -5;I<=5;I++) \
                  print I " is" (oddp(I) ? "" : " not") " an odd number" ;\
	        print "";\
                for(I= -5;I<=5;I++) \
                  print I " is" (evenp(I) ? "" : " not") " an even number" ;\
                print "";\
                for(I= -5;I<=5;I++) \
                  print "the absolute value of " I " is " abs(I);\
		srand(1);\
		print "";\
		I=10; while(I--) {X=rand()*10 - 5 ; print X " rounds to " round(X)};\
		print "";\
                print "The mean of (3,5) is " mean(3+5,2) ;\
		print "";\
		print "A number between 3 and 3 is " between(3,3);\
		print "";\
		print "A number between 3 and 5 is " between(3,5);\
		print "";\
                print "The most and least of (3,5) is (" most(3,5) ", " least(3,5) ")";\
             $z
