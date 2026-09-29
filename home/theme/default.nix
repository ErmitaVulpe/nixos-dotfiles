{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.homeModules.theme;
in
{
  options.homeModules.theme = {
    enable = lib.mkEnableOption "themeing with stylix";
  };

  imports = [
    ./wallpaper
    inputs.stylix.homeModules.stylix
  ];

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      targets = {
        fish.enable = false;
        foot.enable = false;
        tmux.enable = false;
        neovim.enable = false;
      };
    };
  };
}
