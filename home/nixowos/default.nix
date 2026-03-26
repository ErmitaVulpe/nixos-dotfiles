{
  config,
  lib,
  ...
}:
{
  options.homeModules.nixowos = {
    enable = lib.mkEnableOption "Enables nixowos";
  };

  config = lib.mkIf config.homeModules.nixowos.enable {
    nixpkgs.overlays = [
      (import ../../overlays/fastfetch)
      (import ../../overlays/hyfetch)
      (import ../../overlays/nixos-icons)
    ];
  };
}
