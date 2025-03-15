{ ... }:

{
  users.users."${USERNAME_FIELD}" = {
    isNormalUser = true;
    home = "/home/${USERNAME_FIELD}";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };
}
