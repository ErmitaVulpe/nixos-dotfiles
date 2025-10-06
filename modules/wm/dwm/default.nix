{ config, lib, pkgs, inputs, ... }: with lib; {
  config = {
    environment.systemPackages = with pkgs; [
      xorg.xauth
      xorg.xf86inputlibinput
      dmenu
      feh
    ];
    services.xserver = {
      enable = true;
      xkb.layout = "pl";
      displayManager.startx = {
        enable = true;
        generateScript = true;
      };
    };
    services.xserver.windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./dwm-6.6;
      };
    };
    fonts.packages = with pkgs; [
      dejavu_fonts
      terminus_font
    ];
  };
}

