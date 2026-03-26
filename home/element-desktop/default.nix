{ config, lib, ... }:
{
  options.homeModules.element-desktop = {
    enable = lib.mkEnableOption "Enables element-desktop";
  };

  config = lib.mkIf config.homeModules.element-desktop.enable {
    programs.element-desktop = {
      enable = true;
    };
  };
}
