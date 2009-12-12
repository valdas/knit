include $(Knit)/make/tricks.mk

Loads = -f $(Lib)/$(subst .awk ,.awk -f $(Lib)/,$(Code))

debug :
	echo lib $(Lib)

$(Lib)/%.awk : %.wak
	gawk -f $(Knit)/awk/comment.awk $< > $@

$(Html)/%.html : %.wak
	gawk -f $(Knit)/awk/markdown.awk $< > $@

Vars = $(Tmp)/vars.out
Profile = $(Tmp)/profile.out
Spy  = $(Hi); pgawk --dump-variables="$(Vars)" \
                     --profile="$(Profile)"   $(Loads) #
Run  = $(Hi); gawk  $(Loads)#
a    = $(Run) -v Test=1 --source 'BEGIN {#
z    = ; exit}'
A    = $(Spy) -v Test=1  --source 'BEGIN {#
Z    = ; exit}'


