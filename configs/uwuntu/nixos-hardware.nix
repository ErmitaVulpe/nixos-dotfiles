{ pkgs, inputs, lib, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];
  
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  hardware.nvidia = {
    open = false;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services = {
    thermald.enable = true;
  };
}
