#Defaults
#Tmp     = $(HOME)/tmp#
#Testdir = eg#

# Banner for top of each test
Hi=printf "\n---| $(Testdir)/$(it) |-----------------------------------------\n\n"

#### end config. You should not need to adjust anything after this.

MAKEFLAGS+= -s -i 
Var      = var
App      = var/app
Html     = var/html
Testdir	 =  eg#
Wants 	 = $(shell cd $(Testdir); ls *.want  | sed 's/.want//'  | sort )#
Htmls   := $(shell gawk -f lib/uses.awk Ext=html Dir=$(Html) $(Main))#
Stem     = $(subst .$(Ext),,$(Main))
Wp       =	gawk -f lib/used2list.awk \
            | gawk -f lib/markdown.awk Toc=$(Html)/$(Stem)_toc.html #
Dirp     = [ ! -d "$d" ] && mkdir -p $d ;

version :  
	echo "KNIT v0.1: Library manageement, documentation, and testing for scripting"

v: version
t: tests
s: score
r: run
g: tags
e: edit
d: debug
c: cache
b: build

ready: dirs files

filesa :
	echo "code: [$(Code)]"
	echo "files: [$(Files)]"
	echo "html: [$(Htmls)]"

files: $(Htmls) $(Html)/knit.html $(Files) 

vim: tags
	cp  lib/vim/doc/[a-z]*    $(HOME)/.vim/doc/
	cp  lib/vim/plugin/[a-z]* $(HOME)/.vim/plugin/

tags:
	ctags -o ~/.vim/tags/knit $(PWD)/*.$(Ext)
	- [ -f "$(HOME)/.vimrc" ] && touch "$(HOME)/.vimrc" 
	echo "Remember to add 'set tags=~/.vim/tags/knit' to ~/.vimrc."

edit:  tags
	vim -t $(it)

dirs:
	-  $(foreach d, $(HOME)/.vim/tags $(HOME)/.vim/doc $(HOME)/.vim/plugin \
                    $(TestDir) $(Var) $(Code) $(Auto) $(App) $(Html), $(Dirp))
	svn propset svn:ignore var . > /dev/null

#####
$(Html)/knit.html : lib/knit.txt
	cat $< | $(Wp) > $@

#### run all tests
tests:;  $(foreach x, $(Wants), echo 11; $(MAKE) -f lib/${Ext}/make.mk it=$x check;)

score :
	$(MAKE) -f lib/${Ext}/make.mk tests \
    | cut -d\  -f 1 | egrep '(PASSED|FAILED)' | sort | uniq -c 

#### run one test
check : $(Testdir)/$(it).want
	$(MAKE) -f lib/${Ext}/make.mk run | tee $(Tmp)/$(it).got 
	if   diff -s $(Tmp)/$(it).got $(Testdir)/$(it).want > /dev/null;  \
        then echo PASSED $(it) ; \
        else echo FAILED $(it),  got $(Tmp)/$(it).got; \
    fi

bundle: dirs $(App)/$(Main)

$(App)/$(Main) : lib/$(Ext)/copyright.txt $(Files) 
	(echo $(Header) ;cat $^ ) > $(App)/$(Stem)
	chmod +x $(App)/$(Stem)
	echo "Remember to add $(App) to your PATH variable in ~/.bashrc."

cache : ready
	$(MAKE) -f lib/${Ext}/make.mk run | tee $(Testdir)/$(it).want
	echo new test result cached to $(Testdir)/$(it).want
