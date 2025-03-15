#!/bin/sh

USERS_DIR="${BASE_DIR}/src/conf/users"
TEMPLATES_DIR="${BASE_DIR}/src/templates"

if [ "$(find "$USERS_DIR" -maxdepth 1 -type f ! -name "default.nix" | wc -l)" -gt 0 ]; then
  exit 0
fi

echo "No users were defined in $USERS_DIR directory. Generating a default user..."
echo "Enter the username: "
read -r USERNAME_FIELD

export USERNAME_FIELD
envsubst < "$TEMPLATES_DIR/user.template.nix" 
