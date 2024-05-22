.PHONY: start
start:
	make install-deps
	docker compose up -d

.PHONY: install-deps
install-deps:
	npm run install-all