{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.spotify = {
    enable = lib.mkEnableOption "spotify";
    localDiscovery = lib.mkEnableOption "Opens firewall ports to allow for local discovery" // {
      default = true;
    };
  };

  config = lib.mkIf config.nixosModules.spotify.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];

    networking.firewall = lib.mkIf config.nixosModules.spotify.localDiscovery {
      allowedTCPPorts = [ 57621 ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}
