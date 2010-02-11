all : quill penny docs pdfs misc commit

install :
	@if  [ -z "$(Knit)"      ]; then echo "Please add to (e.g.) .bashrc:     export Knit=\"`pwd`\""; fi
	@if [ -z "$(VPATH)"      ]; then echo "Please add to (e.g.) .bashrc:     export VPATH=\"`pwd`/quill\""; fi
	@if [ -z "$(SVN_EDITOR)" ]; then echo "Please add to (e.g.) .bashrc:     export SVN_EDITOR=\"`which nano`\""; fi
	@if [ -z "`which pgawk`" ]; then echo "WARNING: missing pgawk interpreter. Please install."; fi
	@if [ -z "`which gawk`"  ]; then echo "WARNING: missing gawk interpreter. Please install."; fi
	@if [ -z "`which wget`"  ]; then echo "WARNING: missing wget command. Please install."; fi
	@if [ -z "`which grep`"  ]; then echo "WARNING: missing grep command. Please install."; fi
	@if [ -z "`which svn`"   ]; then echo "WARNING: missing subversion command. Please install."; fi
	@if [ -z "`which sed`"   ]; then echo "WARNING: missing sed command. Please install."; fi
	@[ -n $(Knit) ] && (cd quill; $(MAKE) install)

quill :
		cd quill; $(MAKE) builds

penny :
		cd penny; $(MAKE) tag

commit:
		cd ../../; svn add -q tags; svn -q  add tags/*; svn -q add tags/*/*; svn commit 

docs :
		cd doc; make builds

pdfs :
		cd share/pdf;  svn -q propset svn:mime-type application/pdf *.pdf

Markup=../../tags/markup/0.1
$(Markup)/markup.awk : lib/awk/markup.awk 
	mkdir -p $(Markup) 
	cp $^ $@
	svn add $(Markup) $(Markup)/*

misc : $(Markup)/markup.awk



