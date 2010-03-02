Tmp=$(HOME)/tmp
R    = Seed=$(shell echo $$RANDOM)
Args = -F, -f misc.awk #
Gawk = gawk $(Args)  #
Spy  = pgawk $(Args) --profile=$(Tmp)/profile.out --dump-variables=$(Tmp)/vars.out #
This = data

all : dirs one

dirs :
	@ - [ ! -f "$(HOME)/tmp" ] && mkdir $(HOME)/tmp	

one : $(Tmp)/$(This).norm

$(Tmp)/%.norm : %.arff
	$(Gawk) -f normalize.awk $R $< > $@

main : $(Tmp)/$(This).norm
	$(Gawk) -f read.awk -f dist.awk $R $<
