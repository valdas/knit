ifeq (,$(findstring appele, $(MACHTYPE)))
	Gawk=/opt/local/bin/gawk
	Pgawk=/opt/local/bin/gawk
else	
        Gawk=gawk
	Pgawk=pgawk
endif
