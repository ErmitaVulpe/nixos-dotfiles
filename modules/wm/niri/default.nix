{
  config,
  lib,
  ...
}:
{
  options.nixosModules.wm.niri = {
    enable = lib.mkEnableOption "niri wm";
  };

  config = lib.mkIf config.nixosModules.wm.niri.enable {
    programs.niri.enable = true;
  };
}
