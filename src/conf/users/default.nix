{ ... }:
let
  allFiles = builtins.attrNames (builtins.readDir ./.);
  filteredFiles = builtins.filter (file: file != "default.nix") allFiles;
in
{
  imports = filteredFiles;
}
