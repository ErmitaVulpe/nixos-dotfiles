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
  ## This should work. TODO test on real hardware
  # home.pointerCursor = {
  #   name = "rose-pine";
  #   package = pkgs.rose-pine-cursor;
  #   # gtk.enable = true;
  # };

  # install font
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        # "Hack Nerd Font Propo"
        # "Hack Nerd Font"
        "Hack Nerd Font Mono"
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", preferred, auto, 1";

      input = {
        kb_layout = "pl";
        repeat_delay = 250;
        repeat_rate = 45;
      };

      exec-once = [
        "pkill dunst; dunst"
      ];

      bind = [
        "SUPER, M, exit"
        "ALT, space, exec, rofi -show drun"
        "SUPER, T, exec, foot"
        "SUPER, C, killactive"
        "SUPER SHIFT, C, exec, hyprpicker -an"
        "SUPER CTLR, X, exec, firefox"

        ", F11, fullscreen, 1"
        "SUPER, f, togglefloating"

        # move focus
        "SUPER, h, movefocus, l"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"
        "SUPER, l, movefocus, r"
        "SUPER, left, movefocus, l"
        "SUPER, down, movefocus, d"
        "SUPER, up, movefocus, u"
        "SUPER, right, movefocus, r"

        # move window
        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, j, movewindow, d"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, l, movewindow, r"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, down, movewindow, d"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, right, movewindow, r"

        # resize window
        "SUPER CTRL, h, resizeactive, -50 0"
        "SUPER CTRL, j, resizeactive, 0 50"
        "SUPER CTRL, k, resizeactive, 0 -50"
        "SUPER CTRL, l, resizeactive, 50 0"
        "SUPER CTRL, left, resizeactive, -50 0"
        "SUPER CTRL, down, resizeactive, 0 50"
        "SUPER CTRL, up, resizeactive, 0 -50"
        "SUPER CTRL, right, resizeactive, 50 0"

        # switch workspace
        "SUPER ALT, h, workspace, -1"
        "SUPER ALT, l, workspace, +1"

        # move window to workspace
        "SUPER SHIFT ALT, h, movetoworkspace, -1"
        "SUPER SHIFT ALT, l, movetoworkspace, +1"
      ];

      bindm = [
        # move a floating window
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}
