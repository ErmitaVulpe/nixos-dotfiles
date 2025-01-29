{ pkgs, ... }: {
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
          "wlr/taskbar"
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "custom/exit"
        ];
      }
        // import ./modules.nix;
    };
  };
}
