MAKEFLAGS += --silent

NIXOS_DIR := /etc/nixos/
BASE_DIR := $(shell pwd)
SRC_DIR := ${BASE_DIR}/src

apply-config:
	sudo cp -r -a ${SRC_DIR}/* ${NIXOS_DIR}

build: apply-config
	sudo nixos-rebuild switch

build-fast: apply-config
	sudo nixos-rebuild switch --fast

rebuild: apply-config
	sudo nixos-rebuild switch --rollback

rebuild-fast: apply-config
	sudo nixos-rebuild switch --rollback --fast

