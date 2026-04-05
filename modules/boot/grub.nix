{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.boot.grub = {
    enable = lib.mkEnableOption "grub boot loader";
    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Custom grub theme to use";
    };
  };

  config = lib.mkIf config.nixosModules.boot.grub.enable {
    nixpkgs.overlays = lib.mkIf (config.nixosModules.boot.grub.theme == "bsol") [
      (import ../../overlays/bsol-grub-theme)
    ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = lib.mkMerge [
        {
          enable = true;
          efiSupport = true;
          devices = [ "nodev" ];
        }

        (lib.mkIf config.nixosModules.boot.multiBoot {
          useOSProber = true;
        })

        (lib.mkIf (config.nixosModules.boot.grub.theme != null) {
          theme =
            {
              bsol = "${pkgs.bsol-grub-theme}";
            }
            .${config.nixosModules.boot.grub.theme};
        })
      ];
    };
  };
}
