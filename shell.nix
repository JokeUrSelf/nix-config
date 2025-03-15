{ pkgs ? import <nixpkgs> {} }:

let
  NIXOS = "/etc/nixos";
  BASE_DIR = builtins.toString ./.;
  SRC_DIR = "${BASE_DIR}/src";
in

pkgs.mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.gettext
    (pkgs.callPackage ./nix-editor {})
  ];

  shellHook = ''
    if [ -f .env ]; then
      set -a
      source .env.dev
      set +a
    fi

    export NIXOS=${NIXOS}
    export BASE_DIR=${BASE_DIR}
    export DIST_DIR=${BASE_DIR}/dist
    export SRC_DIR=${SRC_DIR}
    export CONF_DIR=${SRC_DIR}/conf
    export GEN_DIR=${SRC_DIR}/generators

    if [ -f .env ]; then
      set -a
      source .env
      set +a
    fi
  '';
}
