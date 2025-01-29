{ pkgs, lib, ... }: with lib; {
  options.hyprlock = {
    enableFprintd = mkOption {
      type = types.bool;
      default = false;
      description = "Enables fingerprint auth with fprintd";
    };
  };

  config = {
    home.packages = with pkgs; [
      hyprlock
    ];

    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "SUPER CTRL, x, exec, hyprlock"
        ];
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        input-field = {
          monitor = "*";
          size = "200, 50";
          position = "0, 100";
          dots_centered = true;
          fade_on_empty = true;
          outline_thickness = 2;
          outline_color = "FFFFFFFF";
          inner_color = "000000AA";
          font_color = "FFFFFFFF";
          shadow_passes = 2;
        };

        general = {
          hide_cursor = true;
          grace = 2;
        };
      };
    };
  };
}

