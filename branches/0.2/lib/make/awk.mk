# must be first
include $(Knit)/lib/make/tricks.mk

Uses    := $(shell gawk -f $(Knit)/lib/awk/uses.awk $(This).wak)#
Awks    := $(subst .wak,.awk,$(Uses))
LibAwks :=  $(subst $(Lib)/ ,,$(Lib)/$(subst .awk ,.awk $(Lib)/,$(Awks)) $(Lib)/$(This).awk)#
Loads   := -f $(subst .awk ,.awk -f ,$(LibAwks))
Htmls   := $(subst .wak,.html,$(Uses))
HtmlHtmls :=  $(subset $(Html)/ ,,$(Html)/$(subst .html ,.html $(Html)/,$(Htmls)) $(Html)/$(This).html)#

debug :
	echo uses $(Uses)

OldBuild = $(Old)/$(This).$(Build)
LatestBuild = $(Lib)/$(This)

build : buildAwks buildHtmls #: Build executables and htmls

buildAwks: $(Tmp)/knit.tmp $(OldBuild) $(LatestBuild) 

buildHtmls: $(HtmlHtmls)

$(Tmp)/knit.tmp : $(LibAwks)
	@echo "#!`which gawk` -f " > $@
	@(cat $(Knit)/etc/copyrite.txt; cat $(Knit)/etc/knit.txt) >> $@
	@$(foreach f,$^,\
   	       (printf "\n#==== $f =============\n\n"; cat $f) >> $@;)
	@chmod a+rx $@

$(OldBuild)    : $(Tmp)/knit.tmp; @cp $< $@
$(LatestBuild) : $(Tmp)/knit.tmp; @cp $< $@

$(Lib)/%.awk : %.wak
	@gawk -f $(Knit)/lib/awk/comment.awk $< > $@

$(Html)/%.html : %.wak
	@gawk -f $(Knit)/lib/awk/markup.awk $< > $@

Vars = $(Tmp)/vars.out
Profile = $(Tmp)/profile.out
Spy  = pgawk --dump-variables="$(Vars)" \
                    --profile="$(Profile)" $(Loads) #
Dump = cat $(Profile) | sed '1d' ; cat $(Vars) | egrep -v '^[A-Z]+:'
Run  = gawk  $(Loads)#
A    = $(Spy) -v Test=1  --source 'BEGIN {#
Z    = ; exit}'
a    = $(Run) -v Test=1 --source 'BEGIN {#
z    = ; exit}'

one :
	@$a $(One) $z
