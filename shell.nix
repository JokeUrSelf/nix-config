{
  pkgs ? import <nixpkgs> { },
}:

let
  BASE_DIR = builtins.toString ./.;
  SRC_DIR = "${BASE_DIR}/src";
in

pkgs.mkShell {
  NIXOS = "/etc/nixos";
  BASE_DIR = "${BASE_DIR}";
  DIST_DIR = "${BASE_DIR}/dist";
  SRC_DIR = "${SRC_DIR}";
  CONF_DIR = "${SRC_DIR}/conf";
  GEN_DIR = "${SRC_DIR}/generators";

  buildInputs = [
    pkgs.nixfmt-rfc-style
    pkgs.nil
    pkgs.gnumake
    pkgs.envsubst
    # (pkgs.callPackage ./nix-editor {})
  ];

  shellHook = ''
    if [ -f .env ]; then
      set -a
      source "${./.env}"
      set +a
    fi

    echo "Generating .nix.env file..."

    > .nix.env

    EXCLUDE_VARS=("PWD" "SHLVL" "OLDPWD" "_" "SHELL" "HOME" "USER" "LOGNAME" "TERM" "DISPLAY" "SSH_AUTH_SOCK" "SSH_AGENT_PID")
    EXCLUDE_VARS+=("XDG_SESSION_ID" "XDG_RUNTIME_DIR" "XDG_SESSION_TYPE" "XDG_CURRENT_DESKTOP" "XDG_DATA_HOME" "XDG_CONFIG_HOME" "XDG_CACHE_HOME")
    EXCLUDE_VARS+=("NIX_PATH" "NIX_PROFILES" "NIX_SSL_CERT_FILE" "NIX_SSL_CERT_DIR")

    unset shellHook
    printenv | while IFS= read -r line; do
      [[ "$line" == *"="* ]] || continue
      var="${"$" + "{line%%=*}"}"
      [[ " ${"$" + "{EXCLUDE_VARS[*]}"} " =~ " $var " ]] && continue
      bash -c "export $line" &>/dev/null && echo "$line" >> .nix.env
    done
  '';
}
