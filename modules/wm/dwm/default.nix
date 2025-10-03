{ config, lib, pkgs, inputs, ... }: with lib; {
  config = {
    environment.systemPackages = with pkgs; [
      xorg.xauth
      xorg.xf86inputlibinput
      dmenu
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
    };
    fonts.packages = with pkgs; [
      dejavu_fonts
      terminus_font
    ];
  };
}

