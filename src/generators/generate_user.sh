#!/bin/sh

TEMPLATES="$BASE_DIR/src/generators/templates/"

APPIMAGES_CONF="{ appimageTools }:"

for file in "$APPIMAGES"/*; do
  chmod +x "$file"

  PKG_NAME_FIELD=$(basename $file .AppImage | tr '[:upper:]' '[:lower:]')

  APPIMAGES_CONF=$(cat "$TEMPLATES/appimage.template.nix")
  echo "$APPIMAGES_CONF" >> "$BASE_DIR/dist/appimages.nix"
done
