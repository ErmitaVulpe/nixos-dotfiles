{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    wezterm
  ];

  home.file.".config/wezterm" = {
    source = ./config;
    recursive = true;
  };
}
