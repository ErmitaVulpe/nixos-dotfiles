{
  config,
  lib,
  ...
}:
{
  options.nixosModules.tlp = {
    enable = lib.mkEnableOption "Enables tlp";
  };

  config = lib.mkIf config.nixosModules.tlp.enable {
    services.tlp = {
      enable = true;
    };
  };
}
