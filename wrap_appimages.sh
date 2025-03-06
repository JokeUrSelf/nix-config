#!/bin/sh

NIXOS_DIR="/etc/nixos"
BASE_DIR=$(pwd)

APPIMAGES_CONF="{ appimageTools }:"

for file in "$BASE_DIR/src/appimages"/*; do
chmod +x "$file"

pkg_name=$(basename $file .AppImage | tr '[:upper:]' '[:lower:]')

APPIMAGES_CONF=$(cat <<EOF
$APPIMAGES_CONF

appimageTools.wrapType2 {
  name = "$pkg_name";
  src = builtins.path { path = "$NIXOS_DIR/appimages/$(basename $file)"; };
}
EOF
)
done

echo "$APPIMAGES_CONF" > "$BASE_DIR/src/appimages.nix"
