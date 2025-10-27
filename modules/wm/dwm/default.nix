{ config, lib, pkgs, inputs, ... }: let
  slock-pkg = (pkgs.slock.override {
    extraLibs = with pkgs; [
      xorg.libXinerama
      xorg.libXft
    ];
  }).overrideAttrs (old: {
      src = ./slock-1.6;
    });
in {
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
      brightnessctl
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
    programs.slock = {
      enable = true;
      package = slock-pkg;
    };
    systemd.services.lockBeforeSuspend = {
      description = "Lock session before suspend/hibernate";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${slock-pkg}/bin/slock";
      };
      environment = {
        DISPLAY = ":0";
        XAUTHORITY = "%h/.Xauthority";
      };
      before = [ "sleep.target" ];
      wantedBy = [ "sleep.target" ];
    };
    fonts.packages = with pkgs; [
      dejavu_fonts
      terminus_font
    ];
  };
}

