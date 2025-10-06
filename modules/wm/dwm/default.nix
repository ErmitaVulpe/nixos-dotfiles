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
      # package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
      #   patches = [
      #     (pkgs.fetchpatch {
      #       url = "https://dwm.suckless.org/patches/systray/dwm-systray-20230922-9f88553.diff";
      #       sha256 = "sha256-Kh1aP1xgZAREjTy7Xz48YBo3rhrJngspUYwBU2Gyw7k=";
      #     })
      #   ];
      # });
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

