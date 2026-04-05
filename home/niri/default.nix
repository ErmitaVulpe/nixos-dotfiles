{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.niri = {
    enable = lib.mkEnableOption "Enables niri config";
  };

  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf config.homeModules.niri.enable {
    homeModules.launcher.wofi.enable = true;

    home.packages = with pkgs; [
      foot
      swayidle
      swaylock
      # waybar
      wofi
      xwayland-satellite
    ];

    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."swaylock/config".source = ./swaylock.conf;
    # home.file.".config/waybar/config".source = ./waybar.conf;
    # home.file.".config/waybar/style.css".source = ./waybar.css;
    home.file.".local/bin/nws.sh".source = ./nws.sh;

    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "top";
          showCapsule = true;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          avatarImage = "/home/drfoobar/.face";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = true;
          name = "Marseille, France";
        };
      };
    };
  };
}
