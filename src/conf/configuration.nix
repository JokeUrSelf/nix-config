{ config, pkgs, ... }:

let
  environment.variables = {
    NIXOS = ./.;
  };

  nix-software-center = import (
    pkgs.fetchFromGitHub {
      owner = "snowfallorg";
      repo = "nix-software-center";
      rev = "0.1.2";
      sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
    }
  ) {};

  local-appimages = import ./appimages.nix { inherit (pkgs) appimageTools lib; };
in
{
  imports = [
    ./hardware-configuration.nix
    ./hardware
    ./users
    ./dark-theme.nix
  ];

  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
  services.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;
    
    windowManager.i3.enable = true;
    
    xkb = {
      layout = "pl,ru";
      variant = "colemak,,";
      options = "grp:alt_shift_toggle";
    };
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  nixpkgs.config = { 
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    local-appimages.apidog
    jre
    ghostty
    flameshot

    vscode
    jetbrains.pycharm-community
    jetbrains.rider

    efibootmgr
    gcc
    git
    gh
    gnumake
    btop
    fzf
    zip
    unzip

    nix-software-center
    google-chrome
    telegram-desktop
  ];

  environment.shellInit = ''
    /etc/nixos/src/scripts/multiple-monitors.sh
  '';

  system.stateVersion = "24.11";
}
