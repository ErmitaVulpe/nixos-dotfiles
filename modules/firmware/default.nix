{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nixosModules.firmware = {
      enable = lib.mkEnableOption "firmware related config, should be used on real machines";
    };
  };

  config = lib.mkIf config.nixosModules.firmware.enable {
    hardware.firmware = [ pkgs.linux-firmware ];
    services.fwupd.enable = true;
  };
}
