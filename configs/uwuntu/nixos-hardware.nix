{ pkgs, inputs, lib, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];
  
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    nvitop
  ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload.enable = true;
    };
    powerManagement = {
      enable = true;
      finegrained = true;
    };
  };

  # Custom driver settings to lower power usage
  boot.kernelParams = [
    "i915.enable_psr=1"
    "i915.enable_dc=4"
    "i915.enable_fbc=1"
    "i915.enable_guc=3"
  ];

  services = {
    thermald.enable = true;
  };
}
