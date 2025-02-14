MAKEFLAGS += --silent

NIXOS_DIR := $(shell echo $$NIX_PATH | sed 's/.*nixos-config=\([^:]*\)\/.*/\1/')
BASE_DIR := $(shell pwd)
DIST_DIR := ${BASE_DIR}/dist

apply-config:
	sudo cp -r -a ${DIST_DIR}/* ${NIXOS_DIR}

build:
	sudo nixos-rebuild switch

build-fast:
	sudo nixos-rebuild switch --fast

rebuild:
	sudo nixos-rebuild switch --rollback

rebuild-fast:
	sudo nixos-rebuild switch --rollback --fast

