{ lib, config, ... }:
{
  options.nixosModules.dconf = {
    enable = lib.mkEnableOption "Enables the dconf service, required for GTK themes";
  };

  config = lib.mkIf config.nixosModules.dconf.enable {
    programs.dconf.enable = true;
  };
}
