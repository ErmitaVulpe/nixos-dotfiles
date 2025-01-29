{
  "hyprland/workspaces" = {
    on-click = "activate";
    active-only = "false";
    all-outputs = "true";
    format = "{id}";
    persistent-workspace."*" = 5;
  };

  "hyprland/window" = {
    format = "{class}";
  };

  "wlr/taskbar" = {
    on-click = "activate";
    on-click-right = "close";
  };
}
