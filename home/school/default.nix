{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.school = {
    enable = lib.mkEnableOption "programs required by my school";
  };

  config = lib.mkIf config.homeModules.school.enable {
    home.packages = with pkgs; [
      anki-bin
      drawio
      (quartus-prime-lite.overrideAttrs {
        supportedDevices = [ "Cyclone IV" ];
      })
    ];
  };
}
