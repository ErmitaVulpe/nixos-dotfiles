{ pkgs, lib, ... }: {
  imports = [ ./rose-pine ];

  wayland.windowManager.hyprland.systemd.enable = true;
}
