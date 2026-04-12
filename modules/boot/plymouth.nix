{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixosModules.boot.plymouth;

  themes = {
    polishcow = {
      theme = "polishcow";
      themePackages = [ pkgs.polishcow-plymouth-theme ];
    };
  };
in
{
  options.nixosModules.boot.plymouth = {
    enable = lib.mkEnableOption "plymouth";
    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Custom pytmouth theme to use";
    };
  };

  config = lib.mkIf config.nixosModules.boot.plymouth.enable {
    nixpkgs.overlays = lib.mkIf (config.nixosModules.boot.plymouth.theme == "polishcow") [
      (import ../../overlays/polishcow-plymouth-theme)
    ];

    boot = {
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];
    };

    boot.plymouth = lib.mkMerge [
      { enable = true; }

      (if cfg.theme != null then themes.${cfg.theme} else { })
    ];
  };
}
