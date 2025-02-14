{ config, pkgs, lib, ... }:

let
  nixConfigRepo = builtins.fetchGit {
    url = "https://github.com/JokeUrSelf/nix-config.git";
    ref = "main";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${nixConfigRepo}/src/configuration.nix")
  ];
}
