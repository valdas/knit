# must be first
include $(Knit)/lib/make/tricks.mk

Uses    := $(shell $(Gawk0) -f $(Knit)/lib/awk/uses.awk $(This).wak)
Awks    := $(subst .wak,.awk,$(Uses))
LibAwks   :=  $(subst $(Lib)/ ,,$(Lib)/$(subst .awk ,.awk $(Lib)/,$(Awks)) $(Lib)/$(This).awk)#
Loads   := -f $(subst .awk ,.awk -f ,$(LibAwks))

Htmls   := $(subst .wak,.html,$(Uses))
HtmlHtmls :=  $(subst $(Html)/ ,,$(Html)/$(subst .html ,.html $(Html)/,$(Htmls)) $(Html)/$(This).html)#

OldBuild = $(Old)/$(This).$(Version)
LatestBuild = $(Lib)/$(This)

build : buildAwks buildHtmls #: Build executables and htmls

buildAwks: $(Tmp)/knit.tmp 
	cp $(Tmp)/knit.tmp $(OldBuild)
	cp $(Tmp)/knit.tmp $(LatestBuild)

buildHtmls: $(HtmlHtmls)

$(Tmp)/knit.tmp : $(LibAwks)
	@echo "#!$(Gawk0) -f " > $@ 
	@(cat $(Knit)/etc/knit.txt; echo "# Built on `date` by $(USER). ") >> $@
	@cat $(Knit)/etc/copyrite.txt >> $@
	@$(foreach f,$^,\
		(printf "\n# $(shell basename $f) \n"; \
		$(Gawk0) '/^#/{next}/^[ \t]*$$/{next}{print}'  $f) >> $@;)
	@chmod a+rx $@
	@echo $(Tmp)/knit.tmp


$(Lib)/%.awk : %.wak
	 cat $< | \
         $(Gawk0) -f $(Knit)/lib/awk/comment.awk   > $@

$(Html)/%.html : %.wak
	$(Gawk0) -f $(Knit)/lib/awk/markup.awk $< > $@

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
           /^[ \t]function[ \t]*demo.*\(/ {print $$3"()"; exit}' $u.wak

awk :
	@printf "LibAwks $(LibAwks)\n\n"
	@printf "gawk $(Gawk)\n\n"
	@printf "run $(Run)\n\n"
	@printf "spy $(Spy)\n\n"
	@printf "$a $(One) $z"

one : 
	@$a $(One) $z
