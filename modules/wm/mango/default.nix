{
  config,
  lib,
  ...
}:
{
  options.nixosModules.wm.mango = {
    enable = lib.mkEnableOption "mango wm";
  };

  config = lib.mkIf config.nixosModules.wm.mango.enable {
    programs.mangowc.enable = true;
  };
}
