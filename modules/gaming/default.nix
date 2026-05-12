{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.nixosModules.gaming = {
    enable = lib.mkEnableOption "gaming platforms";
  };

  config = lib.mkIf config.nixosModules.gaming.enable {
    # TEMP fix for lutris failing to build
    nixpkgs.overlays = [
      (final: prev: {
        openldap = prev.openldap.overrideAttrs (_: {
          doCheck = false;
        });
      })
    ];

    environment.systemPackages = with pkgs; [
      SDL2
      lutris
      prismlauncher
      protontricks
      wineWow64Packages.full
      winetricks
    ];
    programs.steam = {
      enable = true;
      protontricks.enable = true;
    };
  };
}
