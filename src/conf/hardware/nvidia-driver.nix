{ config, lib, ... }:
let 
  nvidiaDriverPackage = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "550.40.07";

    settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
    sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
    openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
    sha256_aarch64 =  lib.fakeHash;
    persistencedSha256 = lib.fakeHash;
  };
in 
{
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.initrd.kernelModules = [ "nvidia" "i915" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    package = nvidiaDriverPackage;

    prime = {
      offload = { enable = true; enableOffloadCmd = true; };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
