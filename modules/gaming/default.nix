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
