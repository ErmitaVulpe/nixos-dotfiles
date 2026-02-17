{ pkgs, lib, ... }:
with lib;
{
  environment.systemPackages = with pkgs; [
    SDL2
    lutris
    protontricks
    wineWow64Packages.full
    winetricks
  ];
}
