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

  services = {
    thermald.enable = true;
  };
}
