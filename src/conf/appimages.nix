{ appimageTools, lib, ... }:

let
  removeExtension = str: builtins.elemAt (builtins.split "\\." str) 0;
  dashesToUnderscores = str: builtins.replaceStrings ["-"] ["_"] str;
  spacesToUnderscores = str: builtins.replaceStrings [" "] ["_"] str;
  convertToPkgName = name: lib.strings.toLower (dashesToUnderscores (spacesToUnderscores (removeExtension (builtins.baseNameOf name))));

  appimages_path = builtins.getEnv "APPIMAGES";
  appimages = builtins.attrNames (builtins.readDir appimages_path);
  appimage_pkgs = builtins.listToAttrs (builtins.map (appimage: rec {
    name = convertToPkgName appimage;
    value = appimageTools.wrapType2 {
      name = "${name}";
      src = builtins.path { path = "${appimages_path}/${appimage}"; };
    };
  }) appimages);
in

appimage_pkgs
