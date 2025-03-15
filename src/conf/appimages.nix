{ appimageTools, lib, ... }:

let
  spacesToUnderscores = str: builtins.replaceStrings [ " " ] [ "_" ] str;
  firstToLower =
    str:
    let
      firstChar = builtins.substring 0 1 str;
      restChars = builtins.substring 1 (builtins.stringLength str) str;
    in
    lib.strings.toLower firstChar + restChars;
  getPackageName =
    dir:
    lib.pipe dir [
      builtins.readDir
      builtins.attrNames
      (lib.filter (name: lib.hasSuffix ".desktop" name))
      builtins.head
      (lib.removeSuffix ".desktop")
      spacesToUnderscores
      firstToLower
    ];

  appimages_path = builtins.getEnv "APPIMAGES";
  appimages = builtins.attrNames (builtins.readDir appimages_path);

  appimage_pkgs = builtins.map (
    appimage:
    let
      src = builtins.path { path = "${appimages_path}/${appimage}"; };
      appimageContents = appimageTools.extract { inherit src ;name=appimage; };
      name = getPackageName "${appimageContents}";
    in
    appimageTools.wrapType2 {
      inherit src name;
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${name}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${name}.desktop --replace-quiet 'Exec=AppRun' 'Exec=${name}'
        cp -r ${appimageContents}/usr/share/icons $out/share
      '';
    }
  ) appimages;
in

appimage_pkgs
