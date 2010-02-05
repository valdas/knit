all : pdfs
		cd quill; $(MAKE) builds
		cd penny; $(MAKE) tag
		svn commit -m "building the site"

pdfs :
		cd share/pdf
		svn -q propset svn:mime-type application/pdf *.pdf
