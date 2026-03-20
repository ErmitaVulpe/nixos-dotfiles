{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.school = {
    enable = lib.mkEnableOption "Enables programs required by my school";
  };

  config = lib.mkIf config.nixosModules.school.enable {
    environment.systemPackages = with pkgs; [
      anki-bin
      logisim-evolution
      quartus-prime-lite
    ];
  };
}
