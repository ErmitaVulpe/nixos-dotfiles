{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    asciiquarium
    cbonsai
    cmatrix
  ];
}
