{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.school = {
    enable = lib.mkEnableOption "programs required by my school";
  };

  config = lib.mkIf config.nixosModules.school.enable {
    environment.systemPackages = with pkgs; [
      anki-bin
      drawio
      logisim-evolution
      quartus-prime-lite
    ];
  };
}
