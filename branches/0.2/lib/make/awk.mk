# must be first
include $(Knit)/lib/make/tricks.mk

debug :
	echo lib $(Lib)

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

# must be last
Needs := $(shell gawk -f $(Knit)/lib/awk/uses.awk $(Code)) $(Code)#
Loads := -f $(Lib)/$(subst  .wak ,.awk -f $(Lib)/,$(Needs))