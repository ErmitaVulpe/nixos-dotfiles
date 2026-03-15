{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (import ../../../overlays/fsel { fselFlake = inputs.fsel; })
  ];
  home.packages = with pkgs; [
    fsel
  ];
}
