{ pkgs, lib, ... }: with lib; {
  environment.defaultPackages = with pkgs; mkForce [
    btop
    fastfetch
    file
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

  i18n = mkDefault {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_COLLATE = "C";
      LC_TIME = "en_GB.UTF-8";
    };
    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  console = mkDefault {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  environment.shellAliases = {
    cls = "clear";
    egrep = "egrep --color=auto01;34";
    fgrep = "fgrep --color=auto";
    grep = "grep --color=auto";
    l = null;
    ll = "ls -lah";
    ls = "ls --color=tty";
  };

  programs = mkDefault {
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
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
