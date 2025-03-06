{ appimageTools }:

appimageTools.wrapType2 {
  name = "apidog";
  src = builtins.path { path = "/etc/nixos/appimages/Apidog.AppImage"; };
}
