# must be first
include $(Knit)/lib/make/tricks.mk
VPATH=./:$(AWKPATH)

Waks  = $(shell gawk -f $(Knit)/lib/awk/uses.awk $(This).wak) $(This).wak#
Awks  = $(subst  .wak,.awk,$(Waks))#
LibAwks = $(Lib)/$(subst .awk ,.awk $(Lib)/,$(Awks))#
Loads = -f $(subst .awk ,.awk -f ,$(AwkLibs))

debug :
	echo lib $(Lib)

bundle : $(LibAwks) #: Combine all the dependancies into one file
	(echo "#!`which gawk` -f ";   \
	cat $(Knit)/etc/copyrite.txt; \
	cat $(Knit)/etc/knit.txt;       \
	cat $^ ) >  $(Tmp)/knit.tmp
	cp $(Tmp)/knit.tmp $(Lib)/$(This).$(Version)
	cp $(Tmp)/knit.tmp $(Lib)/$(This)
	chmod a+rx $(Lib)/$(This).$(Version)
	chmod a+rx $(Lib)/$(This)


$(Lib)/%.awk : %.wak
	gawk -f $(Knit)/lib/awk/comment.awk $< > $@

$(Html)/%.html : %.wak
	gawk -f $(Knit)/lib/awk/markup.awk $< > $@

Vars = $(Tmp)/vars.out
Profile = $(Tmp)/profile.out
Spy  = $(Hi); pgawk --dump-variables="$(Vars)" \
                     --profile="$(Profile)"   $(Loads) #
Run  = $(Hi); gawk  $(Loads)#
a    = $(Run) -v Test=1 --source 'BEGIN {#
z    = ; exit}'
A    = $(Spy) -v Test=1  --source 'BEGIN {#
Z    = ; exit}'

