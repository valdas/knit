# must be first
include $(Knit)/lib/make/tricks.mk

Uses    := $(shell $(Gawk) -f $(Knit)/lib/awk/uses.awk $(This).wak)#
Awks    := $(subst .wak,.awk,$(Uses))
LibAwks   :=  $(subst $(Lib)/ ,,$(Lib)/$(subst .awk ,.awk $(Lib)/,$(Awks)) $(Lib)/$(This).awk)#
Loads   := -f $(subst .awk ,.awk -f ,$(LibAwks))

Htmls   := $(subst .wak,.html,$(Uses))
HtmlHtmls :=  $(subst $(Html)/ ,,$(Html)/$(subst .html ,.html $(Html)/,$(Htmls)) $(Html)/$(This).html)#

OldBuild = $(Old)/$(This).$(Version)
LatestBuild = $(Lib)/$(This)

build : buildAwks buildHtmls #: Build executables and htmls

buildAwks: $(Tmp)/knit.tmp $(OldBuild) $(LatestBuild) 

buildHtmls: $(HtmlHtmls)

$(Tmp)/knit.tmp : $(LibAwks)	
	@echo $(LibAwks)
	@echo "#!$(Gawk) -f " > $@ 
	@(cat $(Knit)/etc/copyrite.txt; cat $(Knit)/etc/knit.txt) >> $@
	@echo "# Built on `date` by $(USER). " >> $@
	@$(foreach f,$^,\
 	       (printf "\n# $(shell basename $f) \n"; \
               $(Gawk) '/^#/{next}/^[ \t]*$$/{next}{print}'  $f) >> $@;)
	@chmod a+rx $@

$(OldBuild)    : $(Tmp)/knit.tmp; @cp $< $@
$(LatestBuild) : $(Tmp)/knit.tmp; @cp $< $@

$(Lib)/%.awk : %.wak
	 $(Gawk) -f $(Knit)/lib/awk/comment.awk $< > $@

$(Html)/%.html : %.wak
	$(Gawk) -f $(Knit)/lib/awk/markup.awk $< > $@

Vars = $(Tmp)/vars.out
Profile = $(Tmp)/profile.out
Spy  = $(Pgawk)     --dump-variables="$(Vars)" \
                    --profile="$(Profile)" $(Loads) #
Dump = cat $(Profile) | sed '1d' ; cat $(Vars) | egrep -v '^[A-Z]+:'
Run  = $(Gawk)  $(Loads)#
A    = $(Spy) -v Test=1  --source 'BEGIN {#
Z    = ; exit}'
a    = $(Run) -v Test=1 --source 'BEGIN {#
z    = ; exit}'

Demo=$(Pgawk) 'BEGIN                     { FS="[ \t(]" } \
           /^[ \t]function[ \t]*demo.*\(/ {print $$3"();"; exit}' $u.wak

awk :
	@echo "gawk $(Gawk)"
	@echo "run $(Run)"
	@echo "spy $(Spy)"

one :
	@$a $(One) $z
