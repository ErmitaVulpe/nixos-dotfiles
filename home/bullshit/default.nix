{ pkgs, ... }:
{
  home.packages = with pkgs; [
    asciiquarium
    cbonsai
    cmatrix

    byobu
    hollywood
  ];
}
