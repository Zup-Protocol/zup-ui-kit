.PHONY: gen, test

gen:
	@fvm dart run build_runner build --delete-conflicting-outputs

update-goldens:
	@rm -rf test/golden_test/**/goldens && fvm flutter test --update-goldens && rm -rf test/golden_test/**/failures

test:
	@fvm flutter test --coverage --test-randomize-ordering-seed=random && genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html