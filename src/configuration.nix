{ config, pkgs, ... }:

let
  nix-software-center = import (
    pkgs.fetchFromGitHub {
      owner = "snowfallorg";
      repo = "nix-software-center";
      rev = "0.1.2";
      sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
    }
  ) {};
in
{
  imports = [ 
    ./hardware-configuration.nix 
    ./nvidia-configuration.nix 
    ./dark-theme.nix 
    ./systemd-configuration.nix
    ./users.nix
  ];

  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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

  services.libinput.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
    
    xkb = {
      layout = "us";
      variant = "colemak";
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

  nixpkgs.config = { 
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  environment.systemPackages = with pkgs; [
    ghostty
    flameshot

    neovim
    vscode
    jetbrains.pycharm-community

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
    /etc/nixos/scripts/multiple-monitors.sh
  '';

  system.stateVersion = "24.11";
}
