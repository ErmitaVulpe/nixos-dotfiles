{ pkgs, lib, ... }:
with lib;
{
  environment.systemPackages = with pkgs; [
    SDL2
    lutris
    protontricks
    wineWowPackages.full
    winetricks
  ];
}
