{ config, lib, ... }:
{
  options.homeModules.hyfetch = {
    enable = lib.mkEnableOption "hyfetch";
  };

  config = lib.mkIf config.homeModules.hyfetch.enable {
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.5;
        color_align = {
          mode = "horizontal";
          custom_colors = [ ];
          fore_back = null;
        };
        backend = "fastfetch";
        args = null;
        distro = null;
        pride_month_shown = [ ];
        pride_month_disable = false;
      };
    };
  };
}
