.ONESHELL:

MAKEFLAGS += --silent

NIXOS_DIR := $(shell echo $$NIX_PATH | sed 's/.*nixos-config=\([^:]*\)\/.*/\1/')
BASE_DIR := $(shell pwd)
SRC_DIR := ${BASE_DIR}/src

backup-config:
	CURRENT_DATE=$$(date +"%Y-%m-%d_%H-%M-%S")

	if [[ $$(ls ${NIXOS_DIR}) = *[!\ ]* ]]; then
		mkdir -p ${BASE_DIR}/backup/$$CURRENT_DATE
		cp -r -a ${NIXOS_DIR}/* ${BASE_DIR}/backup/$$CURRENT_DATE
	fi

generate-dependencies:
	sudo ${BASE_DIR}/wrap_appimages.sh

apply-config: backup-config generate-dependencies
	sudo rm -rf ${NIXOS_DIR}/*
	sudo sh -c "nixos-generate-config --show-hardware-config >> ${NIXOS_DIR}/hardware-configuration.nix"
	sudo cp -r -a ${SRC_DIR}/* ${NIXOS_DIR}

test:
	sudo nixos-rebuild test

build:
	sudo nixos-rebuild switch

build-fast:
	sudo nixos-rebuild switch --fast

rebuild:
	sudo nixos-rebuild switch --rollback

rebuild-fast:
	sudo nixos-rebuild switch --rollback --fast

alb: apply-config build

.PHONY: test backup-config generate-dependencies apply-config build build-fast rebuild rebuild-fast alb