.ONESHELL:

include .env

MAKEFLAGS += --silent

BASE_DIR := $(shell pwd)
DIST_DIR := ${BASE_DIR}/dist
SRC_DIR := ${BASE_DIR}/src
CONF_DIR := ${SRC_DIR}/conf
GEN_DIR := ${SRC_DIR}/generators

config-backup:
	CURRENT_DATE=$$(date +"%Y-%m-%d_%H-%M-%S")
	if [[ $$(ls ${NIXOS}) = *[!\ ]* ]]; then
		mkdir -p ${BASE_DIR}/backup/$$CURRENT_DATE
		cp -r -a ${NIXOS}/* ${BASE_DIR}/backup/$$CURRENT_DATE
	fi

config-generate:
	-rm -rf ${DIST_DIR}
	mkdir -p ${DIST_DIR}
	cp -r -a ${CONF_DIR}/* ${DIST_DIR}
	for FILE in "${GEN_DIR}"/*; do
		if [ -f "$$FILE" ]; then
			chmod +x $$FILE
			eval $$(cat .env) ./helloworld.sh $$FILE
		fi
	done

config-apply: config-backup config-generate
	sudo rm -rf ${NIXOS}/*
	sudo cp -r -a ${CONF_DIR}/* ${NIXOS}

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

alb: config-apply build

.PHONY: test config-backup config-generate config-apply build build-fast rebuild rebuild-fast alb