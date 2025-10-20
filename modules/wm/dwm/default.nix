{ config, lib, pkgs, inputs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      xorg.xauth
      xorg.xf86inputlibinput
      xorg.libXcursor
      dmenu
      feh
      (dwmblocks.overrideAttrs {
        src = ./dwmblocks;
        version = "0-unstable-2024-08-24";
      })

      # System apps
      pavucontrol
      pamixer
    ];
    services.xserver = {
      enable = true;
      displayManager.startx = {
        enable = true;
        generateScript = true;
      };
      xkb.layout = "pl";
    };
    services.xserver.windowManager.dwm = {
      enable = true;
      package = (pkgs.dwm.override {
        extraLibs = [ pkgs.xorg.libXcursor ];
      }).overrideAttrs (old: {
          src = ./dwm-6.6;
          patches = old.patches ++ [
            ./dwm-6.6/patches/cursorfix.diff
          ];
        });
      extraSessionCommands = ''
        feh --bg-scale ~/.local/share/backgrounds/default.png &
        dwmblocks &
        xset r rate 300 40 &
      '';
    };
    fonts.packages = with pkgs; [
      dejavu_fonts
      terminus_font
    ];
  };
}

