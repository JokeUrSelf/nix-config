.ONESHELL:

MAKEFLAGS += --silent

NIXOS_DIR := $(shell echo $$NIX_PATH | sed 's/.*nixos-config=\([^:]*\)\/.*/\1/')
BASE_DIR := $(shell pwd)
DIST_DIR := ${BASE_DIR}/dist
LOCAL_DIR := ${BASE_DIR}/local
SRC_DIR := ${BASE_DIR}/src

backup-config:
	CURRENT_DATE=$$(date +"%Y-%m-%d_%H-%M-%S")

	if [[ $$(ls ${NIXOS_DIR}) = *[!\ ]* ]]; then
		mkdir -p ${BASE_DIR}/backup/$$CURRENT_DATE
		cp -r -a ${NIXOS_DIR}/* ${BASE_DIR}/backup/$$CURRENT_DATE
	fi

apply-config: backup-config
	sudo cp -r -a ${DIST_DIR}/* ${NIXOS_DIR}

generate-dependencies:
	sudo ${BASE_DIR}/wrap_appimages.sh

apply-config-local: backup-config generate-dependencies
	sudo rm -rf ${NIXOS_DIR}/*
	sudo sh -c "nixos-generate-config --show-hardware-config >> ${NIXOS_DIR}/hardware-configuration.nix"
	sudo cp -r -a ${LOCAL_DIR}/* ${NIXOS_DIR}
	sudo cp -r -a ${SRC_DIR} ${NIXOS_DIR}

build:
	sudo nixos-rebuild switch

build-fast:
	sudo nixos-rebuild switch --fast

rebuild:
	sudo nixos-rebuild switch --rollback

rebuild-fast:
	sudo nixos-rebuild switch --rollback --fast

alb: apply-config-local build