{ pkgs, lib, ... }: with lib; {
  environment.defaultPackages = with pkgs; mkForce [
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
    # font = mkDefault "Lat2-Terminus16";
    font = mkDefault "Uni3-Terminus20";
    keyMap = mkDefault "pl";
  };

  environment.shellAliases = {
    cls = "clear";
    l = null;
    ls = "ls --color=tty";
    ll = "ls -lah";
  };

  programs = {
    nano.enable = mkDefault false;
    neovim = {
      enable = mkDefault true;
      defaultEditor = mkDefault true;
    };
  };
}
