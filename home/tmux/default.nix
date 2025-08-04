{ pkgs, ... }: {
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    baseIndex = 1;
    clock24 = true;
    enable = true;
    extraConfig = ''
      set-option -g status-left-length 50


      # set -g status-style bg=default,fg=#dddddd
      #
      # set -g status-left "#[bg=default,fg=green]#S:#I.#P#{?client_prefix,🦊,  }"
      # set -g status-right '#[fg=magenta]%Y-%m-%d %H:%M'
      #
      # set -g window-status-format '#[fg=grey]#I:#W'
      # set -g window-status-current-format '#[bg=#444444,fg=white,bold]#I:#W'
      #
      # set -g pane-border-style fg=colour238
      # set -g pane-active-border-style fg=colour250
      # set -g message-style bg=black,fg=yellow
      # set -g mode-style bg=black,fg=green



      set -g status-style bg=default
      set -g status-left "#[bg=blue,fg=colour15] #{session_name}#{?client_prefix,🦊,  }"
      set -g status-right "#(~/.config/tmux/git.sh #{pane_current_path})"
      set -g window-status-current-style 'fg=#eafffd bg=#71217b bold'
      set -g window-status-current-format ' #I #W #F '
      set -g window-status-style 'fg=#ddc7a1'
      set -g window-status-format ' #I #[fg=colour7]#W #[fg=#f00]#F '
      set -g mode-style 'fg=silver bg=#44475a bold'
      set -g message-style 'fg=colour6 bg=colour0'
    '';
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
    sensibleOnTop = false;
  };


  home.file.".config/tmux/git.sh" = {
    source = ./git.sh;
  };
}

