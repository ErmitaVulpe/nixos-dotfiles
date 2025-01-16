{ config, pkgs, lib, ... }: with lib; {
  environment.defaultPackages = with pkgs; mkForce [
    fastfetch
    gh
    git
    jq
    neovim
    pciutils
    tmux
    tree
    wget
  ];

  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  console = {
    font = mkDefault "Lat2-Terminus16";
    keyMap = mkDefault "pl";
  };

  environment.shellAliases = {
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
