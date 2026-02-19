{ pkgs, ... }:
let
  slock-pkg =
    (pkgs.slock.override {
      extraLibs = with pkgs; [
        libXinerama
        libXft
      ];
    }).overrideAttrs
      (old: {
        src = ./slock-1.6;
      });
in
{
  config = {
    environment.systemPackages = with pkgs; [
      xf86inputlibinput
      libXcursor
      dmenu
      feh
      (dwmblocks.overrideAttrs {
        src = ./dwmblocks;
        version = "0-unstable-2024-08-24";
        # TEMP fix for https://github.com/NixOS/nixpkgs/issues/475479
        env.NIX_CFLAGS_COMPILE = "-std=gnu17";
      })

      # System apps
      brightnessctl
      scrot
      xclip
      xss-lock
    ];
    services.picom = {
      enable = true;
      backend = "glx";
      vSync = true;
    };
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
      package =
        (pkgs.dwm.override {
          extraLibs = [ pkgs.libXcursor ];
        }).overrideAttrs
          (old: {
            src = ./dwm-6.6;
            patches = old.patches ++ [
              ./dwm-6.6/patches/cursorfix.diff
            ];
          });
      extraSessionCommands = ''
        feh --bg-scale ~/.local/share/backgrounds/default.png &
        dwmblocks &
        xset r rate 300 40 &
        xss-lock -- slock &
      '';
    };
    programs.slock = {
      enable = true;
      package = slock-pkg;
    };
    fonts.packages = with pkgs; [
      dejavu_fonts
      terminus_font
    ];
  };
}
