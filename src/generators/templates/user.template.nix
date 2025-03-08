{ ... }:

let
  user = "${USER_FIELD}";
in

{
  users.users."${user}" = {
    isNormalUser = true;
    home = "/home/${user}";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
}
