{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./waybar
  ];

  home.packages = with pkgs; [
    # cursor
    rose-pine-cursor
    # font
    nerd-fonts.hack
    # notifications
    dunst
    libnotify
    # # wallpaper
    # swww
    # launcher
    rofi-wayland
  ];

  # install cursor pack
  home.file = {
    ".local/share/icons/default" = {
      source = "${pkgs.rose-pine-cursor.outPath}/share/icons/BreezeX-RosePine-Linux";
      recursive = true;
    };
  };

  # install font
  home.file = {
    ".local/share/fonts/default" = {
      source = "${pkgs.nerd-fonts.hack.outPath}/share/fonts/truetype/NerdFonts/Hack";
      recursive = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", preferred, auto, 1";

      exec-once = [
	"dunst"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, M, exit"
        "ALT, space, exec, rofi -show drun"
        "$mod, T, exec, foot"
        "$mod, C, killactive"
      ];
    };
  };
}
