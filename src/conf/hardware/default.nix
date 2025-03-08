{ config, pkgs, ... }:

{
  imports = [ 
    ./nvidia-driver.nix
  ];
}
