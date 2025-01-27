{ pkgs, lib, ... }: with lib; {
  environment.defaultPackages = with pkgs; mkForce [
    btop
    fastfetch
    fzf
    gh
    git
    jq
    neovim
    pciutils
    tmux
    tree
    wget
    yazi
  ];

  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  console = {
    font = mkDefault "Lat2-Terminus16";
    # font = mkDefault "Uni3-Terminus20";
    keyMap = mkDefault "pl";
  };

  environment.shellAliases = {
    cls = "clear";
    l = null;
    ls = "ls --color=tty";
    ll = "ls -lah";
  };

  programs = {
    bash.promptInit = ''
      # Provide a nice prompt if the terminal supports it.
      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;32m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
        else
          PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;\h:\u:\w\007\]$PS1"
        fi
      fi
    '';
    nano.enable = mkDefault false;
    neovim = {
      enable = mkDefault true;
      defaultEditor = mkDefault true;
    };
  };
}
