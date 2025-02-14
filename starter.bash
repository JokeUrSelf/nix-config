#!/usr/bin/env bash

echo "The feature to unwrap example configurations is not yet implemented"
echo "The feature to generate a user is not yet implemented"

ask() {
    echo "$1 (Y/n): "
    read response
    return $([[ $response =~ ^([yY]$|^[yY][eE][sS]$|\s*)$ ]])
}

if ask "Wanna login to your GitHub account?"; then
    gh auth login
fi

if ask "Wanna set your git credentials?"; then
    read -p "Enter your Git name: " git_name
    git config --global user.name "$git_name"

    read -p "Enter your Git email: " git_email
    git config --global user.email "$git_email"
fi