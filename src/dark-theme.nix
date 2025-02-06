{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnome.gnome-themes-extra papirus-icon-theme libsForQt5.qtstyleplugin-kvantum capitaine-cursors ];

  environment.variables = {
    GTK_THEME = "Adwaita-dark"; 
    QT_STYLE_OVERRIDE = "kvantum";
    XDG_CURRENT_DESKTOP = "X-Generic";
    XDG_THEME_NAME = "Adwaita-dark";  
    ELECTRON_FORCE_DARK_MODE = "1";
  };
}
