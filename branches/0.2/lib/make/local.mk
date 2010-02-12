ifeq ($(MACHTYPE),i386-apple-darwin9.0)
	Gawk0=/opt/local/bin/gawk#
	Gawk=$(Gawk0)#
	Pgawk=/opt/local/bin/gawk#
	Lib=../site/src#
        Html=../site#

else	
        Gawk0=gawk
	Gawk=gawk
	Pgawk=pgawk
endif
