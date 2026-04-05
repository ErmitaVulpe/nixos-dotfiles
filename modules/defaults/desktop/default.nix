{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.nixosModules.defaults.desktop = {
    enable = lib.mkEnableOption "Enables default apps and configs for graphic interfaces";
  };

  config = lib.mkIf config.nixosModules.defaults.desktop.enable {
    environment.systemPackages = with pkgs; [
      gimp
      vlc
      wireshark
    ];
    programs.wireshark.enable = true;

    nixosModules = {
      audio.enable = true;
      dconf.enable = true;
      nixowos.enable = true;
      xmrig = {
        enable = true;
        background = true;
      };
    };
  };
}
