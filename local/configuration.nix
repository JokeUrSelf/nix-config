{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./src/configuration.nix
  ];
}
