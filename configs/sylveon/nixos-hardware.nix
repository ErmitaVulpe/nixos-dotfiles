{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    nvitop
  ];

  hardware.enableAllFirmware = true;
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
}
