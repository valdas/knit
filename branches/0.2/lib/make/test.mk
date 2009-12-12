run : #: run one eg (via make u=test run)
	@$(MAKE) u=$u $u

cache : #: run one eg and cache result (via make u=test cache)
	@$(MAKE) run  | tee $(Expect)/$u
	@echo new test result cached to $(Expect)/$u


test : $(Expect)/$u #: test if the cached result is still current
	@$(MAKE) run | tee $(Tmp)/$u.got 
	@if  diff -s $(Tmp)/$u.got $(Expect)/$u > /dev/null;  \
		then echo PASSED $u ; \
		else echo FAILED $u,  got $(Tmp)/$u.got; \
	fi

tests : #: run 'test' on all egs
	@$(foreach x, $(Egs), $(MAKE) u=$x test;) 

score : #: run 'test' on all egs, collect the scores
	$(MAKE) tests | egrep '(PASSED|FAILED)' \
         | gawk '{print $$1}' | uniq -c
