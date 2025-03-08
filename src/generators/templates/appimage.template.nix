{ appimageTools }:

let
  pkg_name = "${PKG_NAME_FIELD}";
in

appimageTools.wrapType2 {
  name = "${pkg_name}";
  src = builtins.path { path = "$APPIMAGES/$(basename $file)"; };
}
