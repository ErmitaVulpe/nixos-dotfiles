{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      urlview
    ];
    sensibleOnTop = false;
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
