{
  config,
  inputs,
  lib,
  ...
}:
{
  options.nixosModules.wm.mango = {
    enable = lib.mkEnableOption "mango wm";
  };

  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  config = lib.mkIf config.nixosModules.wm.mango.enable {
    programs.mango.enable = true;
  };
}
