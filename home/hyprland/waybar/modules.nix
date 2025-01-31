{
  "clock" = {
    interval = 1;
    format = "{:%A, %Y-%m-%d %H:%M:%S}";
    format-alt = "{:%R}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode           = "year";
      mode-mon-col   = 3;
      weeks-pos      = "right";
      on-scroll      = 1;
      format = {
        months =     "<span color='#ffead3'><b>{}</b></span>";
        days =       "<span color='#ecc6d9'><b>{}</b></span>";
        weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
        weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
        today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
    };
    "actions" =  {
      on-click-right = "mode";
      on-scroll-up = "shift_up";
      on-scroll-down = "shift_down";
      on-click-middle = "shift_reset";
    };
  };

  "custom/exit" = {
    format = "";
    on-click = "wlogout";
    tooltip = false;
  };

  power-profiles-daemon = {
    format = "{icon}   {profile}";
    tooltip-format = "Power profile: {profile}\nDriver: {driver}";
    tooltip = true;
    format-icons = {
      default = "";
      performance = "";
      balanced = "";
      power-saver = "";
    };
  };

  "hyprland/window" = {
    format = "{class}";
  };

  "hyprland/workspaces" = {
    on-click = "activate";
    active-only = "false";
    all-outputs = "true";
    format = "{id}";
    persistent-workspace."*" = 5;
  };

  "wlr/taskbar" = {
    on-click = "activate";
    on-click-right = "close";
  };
}
