{ lib, config, ... }:
{
  options.nixosModules.nixowos = {
    enable = lib.mkEnableOption "Enables the nixowos skin";
  };

  config = lib.mkIf config.nixosModules.nixowos.enable {
    nixpkgs.overlays = [
      (import ../../overlays/fastfetch)
      (import ../../overlays/hyfetch)
      (import ../../overlays/nixos-icons)
    ];

    system.nixos = {
      distroName = "NixOwOS";
      distroId = "nixowos";
    };
  };
}
