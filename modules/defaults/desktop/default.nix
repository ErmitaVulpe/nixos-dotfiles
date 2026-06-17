{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.nixosModules.defaults.desktop = {
    enable = lib.mkEnableOption "default apps and configs for graphic interfaces";
  };

  config = lib.mkIf config.nixosModules.defaults.desktop.enable {
    environment.systemPackages = with pkgs; [
      gimp
      libreoffice
      vlc
      wireshark
    ];
    programs.wireshark.enable = true;

    nixosModules = {
      audio.enable = lib.mkDefault true;
      dconf.enable = lib.mkDefault true;
      nixowos.enable = lib.mkDefault true;
      xmrig = {
        enable = lib.mkDefault true;
        background = lib.mkDefault true;
      };
    };
  };
}
