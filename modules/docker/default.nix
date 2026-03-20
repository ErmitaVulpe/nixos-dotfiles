{ lib, config, ... }:
{
  options = {
    nixosModules.docker = {
      enable = lib.mkEnableOption "Enables docker";
    };
  };

  config = lib.mkIf config.nixosModules.docker.enable {
    virtualisation.docker = {
      enable = true;
    };
  };
}
