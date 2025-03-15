.ONESHELL:

MAKEFLAGS += --silent

.nix.env:
	nix-shell --run true

include .nix.env
export

ENV_VARS := "$$(cat ./.env | xargs)"

shell-rebuild:
	nix-shell --run true

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
			$$FILE
		fi
	done

config-apply: config-backup config-generate
	sudo rm -rf ${NIXOS}/*
	sudo cp -r -a ${DIST_DIR}/* ${NIXOS}

nix-editor-update:
	git subtree pull --prefix=nix-editor https://github.com/snowfallorg/nix-editor.git main --squash

nix-editor:
	nix-env -f nix-editor -i nix-editor

test:
	eval sudo ${ENV_VARS} nixos-rebuild test

build:
	eval sudo ${ENV_VARS} nixos-rebuild switch

build-fast:
	eval sudo ${ENV_VARS} nixos-rebuild switch --fast

rebuild:
	eval sudo ${ENV_VARS} nixos-rebuild switch --rollback

rebuild-fast:
	eval sudo ${ENV_VARS} nixos-rebuild switch --rollback --fast

alb: config-apply build

.PHONY: test config-backup config-generate config-apply build build-fast rebuild rebuild-fast alb nix-editor