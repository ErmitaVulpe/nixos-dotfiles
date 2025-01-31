{ config, lib, pkgs, inputs, ... }: with lib;
let
  cfg = config.hyprland;
in {
  options = {
    hyprland = {
      nvidia = mkOption {
        type = types.bool;
        default = true;
      };
      withPowerProfiles = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      hyprland
      xwayland
    ];

    programs.xwayland.enable = true;
    # programs.uwsm.enable = true;
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      # withUWSM = true;
    };

    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      power-profiles-daemon.enable = config.hyprland.withPowerProfiles;
    };

    environment.sessionVariables = mkIf cfg.nvidia {
      # If cursor becomes invisisble
      # WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electorn apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    hardware = mkIf cfg.nvidia {
      graphics.enable = true;
      nvidia.modesetting.enable = true;
    };
  };
}
