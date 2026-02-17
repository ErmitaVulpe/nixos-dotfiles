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

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    nvitop
  ];

  hardware.enableAllFirmware = true;
  hardware.graphics.enable = true;
  hardware.intelgpu = {
    # mediaRuntime = "intel-media-sdk"; # lots of CVEs
    computeRuntime = "legacy";
    vaapiDriver = "intel-media-driver";
  };
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

  powerManagement.powertop.enable = true;

  # Custom driver settings to lower power usage
  boot.kernelParams = [
    "i915.enable_psr=1"
    "i915.enable_dc=4"
    "i915.enable_fbc=1"
    "i915.enable_guc=2"
    # "mem_sleep_default=deep"
  ];

  services = {
    thermald.enable = true;
  };
}
