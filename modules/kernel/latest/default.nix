{ config, lib, pkgs, inputs, ... }: with lib; {
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}

