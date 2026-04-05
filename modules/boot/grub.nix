{
  config,
  lib,
  ...
}:
{
  options.nixosModules.boot.grub = {
    enable = lib.mkEnableOption "grub boot loader";
  };

  config = lib.mkIf config.nixosModules.boot.grub.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
      }
      // lib.mkIf config.nixosModules.boot.multiBoot {
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
}
