{ pkgs, ... }: {
  imports = [
    ./hyprlock
    ./waybar
  ];

  home.packages = with pkgs; [
    hyprpicker
    nerd-fonts.hack
    rofi-wayland
    rose-pine-cursor
    wlogout
    wl-clipboard

    # notifications
    dunst
    libnotify
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
        "pkill dunst; dunst"
      ];

      "$mod" = "SUPER";

      bind = [
        "$mod, M, exit"
        "ALT, space, exec, rofi -show drun"
        "$mod, T, exec, foot"
        "$mod, C, killactive"
        "$mod SHIFT, C, exec, hyprpicker -an"

        ", F11, fullscreen, 1"
        "$mod, f, togglefloating"

        # move focus
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$mod, left, movefocus, l"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"
        "$mod, right, movefocus, r"

        # move window
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, right, movewindow, r"

        # resize window
        "$mod CTRL, h, resizeactive, -50 0"
        "$mod CTRL, j, resizeactive, 0 50"
        "$mod CTRL, k, resizeactive, 0 -50"
        "$mod CTRL, l, resizeactive, 50 0"
        "$mod CTRL, left, resizeactive, -50 0"
        "$mod CTRL, down, resizeactive, 0 50"
        "$mod CTRL, up, resizeactive, 0 -50"
        "$mod CTRL, right, resizeactive, 50 0"

        # switch workspace
        "$mod ALT, h, workspace, -1"
        "$mod ALT, l, workspace, +1"

        # move window to workspace
        "$mod SHIFT ALT, h, movetoworkspace, -1"
        "$mod SHIFT ALT, l, movetoworkspace, +1"
      ];

      bindm = [
        # move a floating window
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
