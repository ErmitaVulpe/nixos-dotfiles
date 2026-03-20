{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.dm.ly = {
    enable = lib.mkEnableOption "Enables the ly dm";
  };

  config = lib.mkIf config.nixosModules.dm.ly.enable {
    environment.systemPackages = with pkgs; [ xauth ];
    services.displayManager.ly = {
      enable = true;
      settings = {
        xauth_cmd = "${pkgs.xauth}/bin/xauth > /dev/null 2>&1";
      };
    };
  };
}
