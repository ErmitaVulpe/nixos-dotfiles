{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "pkill waybar; waybar"
    ];
  };

  programs.waybar = {
    enable = true;
    settings = {
      topBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "bluetooth"
          "pulseaudio"
          "wireplumber"
          "network"
          "power-profiles-daemon"
          "battery"
          "clock"
          "custom/exit"
        ];

        reload_style_on_change = true;
      }
      // import ./modules.nix;
    };
  };
}
