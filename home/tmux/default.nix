{ pkgs, ... }: {
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    baseIndex = 1;
    clock24 = true;
    enable = true;
    extraConfig = ''
      set -g status-style bg=default,fg=#dddddd

      set -g status-left "#[bg=default,fg=green]#S:#I.#P#{?client_prefix,🦊,  }"
      set -g status-right '#[fg=magenta]%Y-%m-%d %H:%M'

      set -g window-status-format '#[fg=grey]#I:#W'
      set -g window-status-current-format '#[bg=#444444,fg=white,bold]#I:#W'

      set -g pane-border-style fg=colour238
      set -g pane-active-border-style fg=colour250
      set -g message-style bg=black,fg=yellow
      set -g mode-style bg=black,fg=green
    '';
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
    sensibleOnTop = false;
  };
}

