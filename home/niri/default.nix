{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    foot
    swaylock
    waybar
    wofi
  ];

  imports = [
    ./wofi.nix
  ];

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."swaylock/config".source = ./swaylock.conf;
  home.file.".config/waybar/config".source = ./waybar.conf;
  home.file.".config/waybar/style.css".source = ./waybar.css;
  home.file.".local/bin/nws.sh".source = ./nws.sh;
}
