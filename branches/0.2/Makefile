all : quill penny docs pdfs commit

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
