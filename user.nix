{ pkgs, ... }:
let
  username = "mik";
in
{
    users.users.mik = {
        isNormalUser = true;
        home = "/home/mik";
        extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
}
