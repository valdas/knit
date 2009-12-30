# must be first
include $(Knit)/lib/make/tricks.mk

Waks  := $(shell gawk -f $(Knit)/lib/awk/uses.awk $(This).wak)#
Awks  := $(subst  .wak,.awk,$(Waks))#
LibAwks := $(Lib)/$(subst .awk ,.awk $(Lib)/,$(Awks))#
Loads := -f $(subst .awk ,.awk -f ,$(LibAwks))

debug :
	echo lib $(Lib)

OldVersion = $(Old)/$(This).$(Version)
LatestVersion = $(Lib)/$(This)

build : $(Tmp)/knit.tmp $(OldVersion) $(LatestVersion) #: Build a single executable file

$(Tmp)/knit.tmp : $(LibAwks)
	@echo "#!`which gawk` -f " > $@
	@(cat $(Knit)/etc/copyrite.txt; cat $(Knit)/etc/knit.txt) >> $@
	@$(foreach f,$^, (printf "\n#==== $f =============\n\n"; cat $f) >> $@;)
	@ls -lsat $(LatestVersion)

$(OldVersion)    : $(Tmp)/knit.tmp; @cp $< $@; chmod a+rx $@
$(LatestVersion) : $(Tmp)/knit.tmp; @cp $< $@; chmod a+rx $@

$(Lib)/%.awk : %.wak
	@gawk -f $(Knit)/lib/awk/comment.awk $< > $@

$(Html)/%.html : %.wak
	gawk -f $(Knit)/lib/awk/markup.awk $< > $@

Vars = $(Tmp)/vars.out
Profile = $(Tmp)/profile.out
Spy  = pgawk --dump-variables="$(Vars)" \
                    --profile="$(Profile)" $(Loads) #
Dump = cat $(Profile); cat $(Vars) | egrep -v '^[A-Z]+:'
Run  = gawk  $(Loads)#
a    = $(Run) -v Test=1 --source 'BEGIN {#
z    = ; exit}'
A    = $(Spy) -v Test=1  --source 'BEGIN {#
Z    = ; exit}'

