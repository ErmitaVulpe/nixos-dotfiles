{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      fingers
      vim-tmux-navigator
    ];
    sensibleOnTop = false;
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
