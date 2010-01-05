ifeq ($(MACHTYPE),i386-apple-darwin9.0)
	Gawk=/opt/local/bin/gawk
	Pgawk=/opt/local/bin/gawk
else	
        Gawk=gawk
	Pgawk=pgawk
endif
