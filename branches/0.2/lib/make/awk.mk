include $(Knit)/tricks.mk

Loads = -f $(Lib)/$(subst .awk ,.awk -f $(Lib)/,$(Code))

$(Lib)/%.awk : %.wak
	gawk -f $(Knit)comment.awk $< > $@

$(Html)/%.html : %.wak
	gawk -f $(Knit)/markdown.awk $< > $@

Vars = $(Tmp)/vars.out
Profile = $(Tmp)/profile.out
Spy  = $(Hi); pgawk --dump-variables="$(Vars)" \
                     --profile="$(Profile)"   $(Loads) #
Run  = $(Hi); gawk  $(Loads)#
a    = $(Run) -v Test=1 --source 'BEGIN {#
z    = ; exit}'
A    = $(Spy) -v Test=1  --source 'BEGIN {#
Z    = ; exit}'


