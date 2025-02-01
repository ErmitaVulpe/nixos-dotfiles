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

      # ---
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ff) 45deg";
        "col.inactive_border" = "rgba(595959ff)";

        layout = "dwindle";
        resize_on_border = true;
        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      decoration = {
        rounding = 6;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 0.875;

        # shadow = {
        #   enabled = true;
        #   range = 10;
        #   render_power = 3;
        #   color = "rgba(ff0000ee)";
        # };

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
    };
  };
}
