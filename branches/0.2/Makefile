all : quill penny docs pdfs misc commit

install :
	@if  [ -z "$(Knit)"      ]; then printf "#Please add to (e.g.) .bashrc:\nexport Knit=\"`pwd`\"\n\n"; fi
	@if [ -z "$(VPATH)"      ]; then printf "#Please add to (e.g.) .bashrc:\nexport VPATH=\"`pwd`/quill\"\n\n"; fi
	@if [ -z "$(Tags)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport Tags=\"`pwd`/tags\"\n\n"; fi
	@if [ -z "$(SVN_EDITOR)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport SVN_EDITOR=\"`which nano`\"\n\n"; fi
	@if [ -z "$(Gawk0)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport Gawk0=\"`which gawk`\"\n\n"; fi
	@if [ -z "$(Gawk)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport Gawk=\"`which gawk`\"\n\n"; fi
	@if [ -z "$(Pgawk)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport SVN_EDITOR=\"`which pgawk`\"\n\n"; fi
	@if [ -z "$(Lib)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport Lib=\"../site/src\"\n\n"; fi
	@if [ -z "$(Html)" ]; then printf "#Please add to (e.g.) .bashrc:\nexport Html=\"../site\"\n\n"; fi
	@if [ -z "`which pgawk`" ]; then echo "WARNING: missing pgawk interpreter. Please install."; fi
	@if [ -z "`which gawk`"  ]; then echo "WARNING: missing gawk interpreter. Please install."; fi
	@if [ -z "`which wget`"  ]; then echo "WARNING: missing wget command. Please install."; fi
	@if [ -z "`which grep`"  ]; then echo "WARNING: missing grep command. Please install."; fi
	@if [ -z "`which svn`"   ]; then echo "WARNING: missing subversion command. Please install."; fi
	@if [ -z "`which sed`"   ]; then echo "WARNING: missing sed command. Please install."; fi
	if [ -n "$(Knit)" -a  -n "$(Tags)" -a -n $(Gawk0) -a -n $(Gawk) -a -n $(Pgawk) -a -n $(Lib) -a -n "$(Html)" ]; \
	 then cd quill; $(MAKE) install; $(MAKE) -B all; \
	 else echo "Install failed."; \
	 fi

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



