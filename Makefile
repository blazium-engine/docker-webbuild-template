#!/usr/bin/env make
MAKEFLAGS += --silent

ifneq (,$(wildcard ./.env))
    include .env
    export
endif



deploy-docker: ## Deploy Built Dockerfile to Registry
	@scripts/deploy.sh

credits: ## Credits for the Project
	@scripts/credits.sh


.PHONY: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {split($$0, P, ":"); split($$0, G, "##"); printf "\033[36m%-16s\033[0m %s\n", P[2], G[2]}'

.DEFAULT_GOAL := help