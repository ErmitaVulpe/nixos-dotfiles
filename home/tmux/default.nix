{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.tmux = {
    enable = lib.mkEnableOption "tmux" // {
      default = true;
    };
  };

  config = lib.mkIf config.homeModules.tmux.enable {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        fingers
        vim-tmux-navigator
      ];
      sensibleOnTop = false;
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
