# standalone-witness — make targets

GO ?= go

.PHONY: build test test-short vet tidy clean help

help: ## List available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN{FS=":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Compile the witness binary to ./bin/standalone-witness
	@mkdir -p ./bin
	$(GO) build -o ./bin/standalone-witness .

test: ## Run the full test suite (unit + daemon e2e)
	$(GO) test -count=1 ./...

test-short: ## Run only the fast unit tests (skips the daemon e2e)
	$(GO) test -short -count=1 ./...

vet: ## go vet across all packages
	$(GO) vet ./...

tidy: ## go mod tidy + verify
	$(GO) mod tidy
	$(GO) mod verify

clean: ## Remove build artifacts
	rm -rf ./bin
