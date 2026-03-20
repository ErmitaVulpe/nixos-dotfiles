{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nixosModules.gaming = {
      enable = lib.mkEnableOption "Enables gaming platforms";
    };
  };

  config = lib.mkIf config.nixosModules.gaming.enable {
    environment.systemPackages = with pkgs; [
      SDL2
      lutris
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
