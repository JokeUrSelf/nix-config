{ appimageTools }:

appimageTools.wrapType2 {
  name = "apidog";
  src = builtins.path { path = "/etc/nixos/src/appimages/Apidog.AppImage"; };
}
