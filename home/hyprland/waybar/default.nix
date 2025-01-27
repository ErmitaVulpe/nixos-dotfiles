{ pkgs, lib, inputs, ... }: {
  home.packages = with pkgs; [
    waybar
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
    ];
  };

  programs.waybar = {
    enable = true;
    settings = {
      topBar = {
        layer = "top";
        position = "top";
        modules-left = [];
        modules-center = [
          "hyprland/workspaces"
        ];

        "hyprland/workspaces" = {
          persistent-workspace."*" = 5;
        };
      };
    };
  };
}
