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
    home = {
      packages = with pkgs; [
        anki-bin
        drawio
        (pkgs.quartus-prime-lite.overrideAttrs {
          supportedDevices = [ "Cyclone IV" ];
        })
      ];

      sessionVariables = {
        SALT_LICENSE_SERVER = "${config.home.homeDirectory}/.altera.quartus/LR-163727_License.dat";
        LM_LICENSE_FILE = "${config.home.homeDirectory}/.altera.quartus/LR-163727_License.dat";
      };
    };
  };
}
