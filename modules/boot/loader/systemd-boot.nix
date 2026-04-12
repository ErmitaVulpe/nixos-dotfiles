{
  config,
  lib,
  ...
}:
{
  options.nixosModules.boot.loader.systemd-boot = {
    enable = lib.mkEnableOption "systemd-boot boot loader";
  };

  config = lib.mkIf config.nixosModules.boot.loader.systemd-boot.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
