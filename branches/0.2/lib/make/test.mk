run : #: run one eg (via make u=test run)
	@$(MAKE) u=$u $u

cache : #: run one eg and cache result (via make u=test cache)
	@$(MAKE) run  | tee $(Tests)/$u
	@echo new test result cached to $(Tests)/$u

test : $(Tests)/$u #: test if the cached result is still current
	@$(MAKE) run | tee $(Tmp)/$u.got 
	@if  diff -s $(Tmp)/$u.got $(Tests)/$u > /dev/null;  \
		then echo PASSED $u ; \
		else echo FAILED $u,  got $(Tmp)/$u.got; \
	fi

caches :  build #: run 'cache' on all egs
	@$(foreach x, $(Egs), $(MAKE) u=$x cache;) 

tests : build #: run 'test' on all egs
	@$(foreach x, $(Egs), $(MAKE) u=$x test;) 

score : #: run 'test' on all egs, collect the scores
	@$(MAKE) tests | egrep '(PASSED|FAILED)' \
         | gawk '{print $$1}' | uniq -c
