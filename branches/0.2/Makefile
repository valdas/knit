all : quill penny docs pdfs misc commit

quill :
		cd quill; $(MAKE) builds

penny :
		cd penny; $(MAKE) tag

commit:
		svn commit 

docs :
		cd doc; make builds

pdfs :
		cd share/pdf;  svn -q propset svn:mime-type application/pdf *.pdf

Markup=../../tags/markup/0.1
$(Markup)/markup.awk : lib/awk/markup.awk ; mkdir -p $(Markup); cp $^ $@; svn add $(Markup) $(Markup)/*

misc : $(Markup)/markup.awk



