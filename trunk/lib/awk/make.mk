# all references to "awk" and specials for calling awk 
include lib/make.mk

Ext         = awk#
Interpreter = $(shell which gawk)#
Flags       = --dump-variables=$(Tmp)/vars.out --profile=$(Tmp)/prof.out #
Debugger    = $(shell which pgawk) $(Flags) #
Header		= $(shell echo "#!`which gawk` -f ")#
Code        = $(Var)/awk
Auto        = $(Var)/awk/auto
Files      := $(shell gawk -f lib/uses.awk  Ext=awk Dir=$(Code) $(Main))#
Run	       := $(Interpreter) -f $(subst .awk ,.awk -f ,$(Files))# run command

$(Code)/%.awk : %.awk
	gawk -f lib/comment.awk Comment="#" $< > $@

$(Html)/%.html : %.awk
	cat $< | $(Wp) > $@

debug : ready $(Testdir)/$(it) 
	make Interpreter="$(Debugger)" run
	printf "\n------------------\nYour globals:\n\n"
	sort $(Tmp)/vars.out | egrep -v '^[A-Z]+:' |cat -n
	printf "\n------------------\nProfile:\n\n"
	cat $(Tmp)/prof.out	

run : ready $(Files) $(Testdir)/$(it) 
	$(Hi)
	$(Run) -f $(Testdir)/$(it)

show :
	$(Run) --source 'BEGIN {$(it)}'
