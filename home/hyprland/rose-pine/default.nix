{ pkgs, lib, inputs, ... }: {
  imports = [
    ./waybar
  ];

  home.packages = with pkgs; [
    # cursor
    rose-pine-cursor
    # notifications
    dunst
    libnotify
    # wallpaper
    swww
    # launcher
    rofi-wayland
  ];

  # install cursor pack
  home.file = {
    ".local/share/icons/rose-pine-cursor" = {
      source = "${pkgs.rose-pine-cursor.outPath}/share/icons/BreezeX-RosePine-Linux";
      recursive = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", preferred, auto, 1";

      exec-once = [
	"dunst"
        "hyprctl setcursor rose-pine-cursor 24"
        # "hyprctl setcursor ${pkgs.rose-pine-cursor.outPath} 24"
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
