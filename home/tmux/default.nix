{ pkgs, ... }: {
  # home.packages = with pkgs; [
  #   tmux
  # ];

  programs.tmux = {
    baseIndex = 1;
    clock24 = true;
    enable = true;
    extraConfig = ''
      set-option -g status-left-length 50
      set-option -g default-terminal "$TERM"
      set -as terminal-features ",xterm-256color:RGB"
      set -g renumber-windows on
      set -s escape-time 0

      # create new.. everything in current pwd
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # window navigation
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # binds for reordering windows
      bind -n C-S-Left swap-window -t -1\; select-window -t -1
      bind -n C-S-Right swap-window -t +1\; select-window -t +1

      # Theme
      set -g mode-style "fg=#0c0c0c,bg=#b6b8bb"
      set -g message-style "fg=#0c0c0c,bg=#b6b8bb"
      set -g message-command-style "fg=#0c0c0c,bg=#b6b8bb"
      set -g pane-border-style "fg=#b6b8bb"
      set -g pane-active-border-style "fg=#78a9ff"
      set -g status "on"
      set -g status-justify "left"
      set -g status-style "fg=#b6b8bb,bg=#0c0c0c"
      set -g status-left-length "100"
      set -g status-right-length "100"
      set -g status-left-style NONE
      set -g status-right-style NONE
      set -g status-left "#[fg=#0c0c0c,bg=#78a9ff,bold] #S #[fg=#78a9ff,bg=#0c0c0c,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#0c0c0c,bg=#0c0c0c,nobold,nounderscore,noitalics]#[fg=#78a9ff,bg=#0c0c0c] #{prefix_highlight} #[fg=#b6b8bb,bg=#0c0c0c,nobold,nounderscore,noitalics]#[fg=#0c0c0c,bg=#b6b8bb] %Y-%m-%d  %I:%M %p #[fg=#78a9ff,bg=#b6b8bb,nobold,nounderscore,noitalics]#[fg=#0c0c0c,bg=#78a9ff,bold] #h "
      setw -g window-status-activity-style "underscore,fg=#7b7c7e,bg=#0c0c0c"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#7b7c7e,bg=#0c0c0c"
      setw -g window-status-format "#[fg=#0c0c0c,bg=#0c0c0c,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#0c0c0c,bg=#0c0c0c,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#0c0c0c,bg=#b6b8bb,nobold,nounderscore,noitalics]#[fg=#0c0c0c,bg=#b6b8bb,bold] #I  #W #F #[fg=#b6b8bb,bg=#0c0c0c,nobold,nounderscore,noitalics]"
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
    executable = true;
  };
}

