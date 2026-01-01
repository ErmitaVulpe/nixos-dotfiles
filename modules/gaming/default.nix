{ pkgs, lib, ... }: with lib; {
  environment.defaultPackages = with pkgs; mkForce [
    lutris
    wineWowPackages.full
    winetricks
    protontricks
  ];
}

