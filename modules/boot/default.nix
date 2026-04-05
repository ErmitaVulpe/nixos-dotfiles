{
  config,
  lib,
  ...
}:
{
  options.nixosModules.boot = {
    multiBoot = lib.mkEnableOption "multi boot specific options";
  };

  imports = [
    ./grub.nix
    ./systemd-boot.nix
  ];

  config = lib.mkIf config.nixosModules.boot.multiBoot {
    time.hardwareClockInLocalTime = true;
  };
}
