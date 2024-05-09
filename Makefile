.PHONY: lint
lint:
	luacheck ./lua

.PHONY: test
test:
	vusted --output=gtest --pattern=.spec ./lua

.PHONY: pre-commit
pre-commit:
	luacheck lua
	vusted lua

