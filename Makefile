NAME="$(shell basename `pwd`)"

.PHONY: all config build doc test small-tests big-tests clean clobber

all: build doc test

config: dist/setup-config

dist/setup-config:
	cabal-dev install-deps
	cabal-dev configure

build: config
	cabal-dev build | cat
	@cabal-dev build &> /dev/null

doc: build
	find src -name '*.hs' | xargs haddock --optghc='-package-db '"$$(ls -d cabal-dev/packages-*.conf)" --no-warnings --odir=doc --html


test: small-tests big-tests

small-tests: build
	find src -name '*.hs' | xargs doctest -package-db "$$(ls -d cabal-dev/packages-*.conf)"
	@echo


big-tests: $(patsubst tests/%/expected,proofs/%.proof,$(shell find tests -name 'expected'))
	-@echo '*** ALL TESTS OK ***'

proofs/%.proof: tests/%/in tests/%/expected
	git clean -f $<
	pushd $< && (../../../dist/build/$(NAME)/$(NAME) || true) > $(NAME).out 2> $(NAME).err && popd
	diff -r $^
	git clean -f $<
	mkdir -p $(dir $@)
	touch $@


clean:
	rm -rf proofs

clobber: clean
	rm -rf dist doc

distclean: clobber
	rm -rf cabal-dev
