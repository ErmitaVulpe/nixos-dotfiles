{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (import ../../../overlays/fsel { fselFlake = inputs.fsel; })
  ];
  home.packages = with pkgs; [
    fsel
  ];
  imports = [
    inputs.otter-launcher.homeModules.default
  ];
  programs.otter-launcher = {
    enable = true;
  };
}
