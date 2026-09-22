{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.launcher.otter-launcher = {
    enable = lib.mkEnableOption "otter-launcher";
  };

  imports = [
    inputs.otter-launcher.homeModules.default
  ];

  config = lib.mkIf config.homeModules.launcher.otter-launcher.enable {
    home.packages = with pkgs; [
      fsel
    ];

    programs.otter-launcher = {
      enable = true;
    };
  };
}
