{ config, pkgs, ... }:

{
  # Enable GTK theme and set it to Adwaita-dark
  environment.systemPackages = with pkgs; [ gnome.gnome-themes-extra papirus-icon-theme libsForQt5.qtstyleplugin-kvantum capitaine-cursors ];

  # Set GTK and QT dark themes
  environment.variables = {
    GTK_THEME = "Adwaita-dark";  # GTK apps will use this theme
    QT_STYLE_OVERRIDE = "kvantum";  # QT apps will use Kvantum for theming
    XDG_CURRENT_DESKTOP = "X-Generic";  # Prevents some apps from forcing a light theme
    XDG_THEME_NAME = "Adwaita-dark";    # Ensures apps recognize the dark theme
    ELECTRON_FORCE_DARK_MODE = "1";
  };

  # Configure X resources for terminals like xterm, urxvt
  # services.xserver.displayManager.sessionCommands = ''
  #   echo "XTerm*background: #1E1E1E" >> ~/.Xresources
  #   echo "XTerm*foreground: #CCCCCC" >> ~/.Xresources
  #   echo "URxvt*background: #1E1E1E" >> ~/.Xresources
  #   echo "URxvt*foreground: #CCCCCC" >> ~/.Xresources
  #   xrdb -merge ~/.Xresources
  # '';
}
