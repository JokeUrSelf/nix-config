{ pkgs, ... }:

let
  rider = pkgs.buildFHSEnv {
    name = "rider";
    targetPkgs = pkgs: [
      pkgs.jetbrains.rider
      pkgs.dotnetCorePackages.dotnet_9.sdk
      pkgs.fontconfig
    ];
    runScript = "${pkgs.jetbrains.rider}/rider/bin/rider";
  };

  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "snowfallorg";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) { };

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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services = {
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    udev.extraRules = ''
      ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", RUN+="${./scripts/monitors-autoconnect.sh}"
    '';

    xserver = {
      enable = true;

      displayManager.lightdm.enable = true;
      displayManager.setupCommands = ''
        PATH=$PATH:/${pkgs.xorg.xrandr}/bin ${./scripts/monitors-autoconnect.sh}
      '';
      windowManager.i3.enable = true;

      xkb = {
        layout = "pl,ru";
        variant = "colemak,,";
        options = "grp:win_space_toggle";
      };
    };
    picom.enable = true;

    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    xfconf.enable = true;
    adb.enable = true;
    firefox.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  virtualisation = {
    docker.enable = true;
    docker.storageDriver = "overlay2";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages =
    with pkgs;
    [
      discord
      jre
      ghostty
      flameshot

      godot_4
      postman

      vscode
      nil
      rider
      jetbrains.pycharm-community
      python3
      python312Packages.pip

      wireplumber
      efibootmgr
      gcc
      git
      gh
      gnumake
      just
      btop
      fzf

      zip
      unzip
      gvfs
      xarchiver
      p7zip
      unrar
      file-roller

      nix-software-center
      google-chrome
      telegram-desktop
    ]
    ++ local-appimages;

  system.stateVersion = "24.11";
}
