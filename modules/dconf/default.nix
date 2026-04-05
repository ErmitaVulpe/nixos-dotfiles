{ lib, config, ... }:
{
  options.nixosModules.dconf = {
    enable = lib.mkEnableOption "dconf service, required for GTK themes";
  };

  config = lib.mkIf config.nixosModules.dconf.enable {
    programs.dconf.enable = true;
  };
}
