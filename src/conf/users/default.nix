{ ... }:

let
  files = builtins.attrNames (builtins.readDir ./.);
  paths = builtins.map (file: (builtins.toString ./.) + "/" + file) (builtins.filter (file: file != "default.nix") files);
in

{
  imports = paths;
}
