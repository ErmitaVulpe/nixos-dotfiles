{ pkgs, lib, inputs, ... }: {
  home.packages = with pkgs; [
    waybar
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
    ];
  };
}
