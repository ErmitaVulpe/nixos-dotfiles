{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  specialisation = {
    with-quadro.configuration = {
      environment.systemPackages = with pkgs; [
        nvitop
      ];

      hardware.nvidia = {
        open = false;
        modesetting.enable = true;
        prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
        powerManagement = {
          enable = true;
          finegrained = true;
        };
      };

      services.xserver.videoDrivers = [ "nvidia" ];
    };
  };

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  hardware.enableAllFirmware = true;
  hardware.graphics.enable = true;
  hardware.intelgpu = {
    # mediaRuntime = "intel-media-sdk"; # lots of CVEs
    computeRuntime = "legacy";
    vaapiDriver = "intel-media-driver";
  };

  boot.kernelModules = [ "iwlwifi" ];
  boot.kernelParams = [
    "i915.enable_psr=0"
    "i915.enable_dc=4"
    "i915.enable_fbc=1"
    "i915.enable_guc=2"
  ];

  services = {
    thermald.enable = true;
  };
}
