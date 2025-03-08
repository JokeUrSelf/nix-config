#!/bin/sh

nixos-generate-config --show-hardware-config >> "${DIST_DIR}/hardware-configuration.nix"