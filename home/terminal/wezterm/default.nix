{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.terminal.wezterm = {
    enable = lib.mkEnableOption "Enables wezterm";
  };

  config = lib.mkIf config.homeModules.terminal.wezterm.enable {
    home.packages = with pkgs; [
      wezterm
    ];

    xdg.configFile.wezterm = {
      source = ./config;
      recursive = true;
    };
  };
}
