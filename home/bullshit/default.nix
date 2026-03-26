{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.bullshit = {
    enable = lib.mkEnableOption "Enables some useless terminal toys";
  };

  config = lib.mkIf config.homeModules.bullshit.enable {
    home.packages = with pkgs; [
      asciiquarium
      cbonsai
      cmatrix

      byobu
      hollywood
    ];
  };
}
