### config
This    = helloworld#
Version = 0.1#
Code    = helloworld.wak#                       

about: 
	@echo "$(This) v$(Version): a very small demo KNIT program"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

### support
Knit = $(HOME)/svns/knit/branches/0.2
include $(Knit)/lib/make/awk.mk

### examples
eg0 : about

eg1 :      #: check that the code does not crash
	@echo $(Needs)
	@echo $(Loads)

