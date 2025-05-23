{ config, pkgs, services, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  
  hardware.nvidia = {
    modesetting.enable = true;

    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

    prime = {
      offload = { enable = true; enableOffloadCmd = true; };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
