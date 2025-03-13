# Filename: Makefile

.PHONY: pre-commit-setup
pre-commit-setup:
	pre-commit install
	pre-commit install --install-hooks
	pre-commit run --all-files
