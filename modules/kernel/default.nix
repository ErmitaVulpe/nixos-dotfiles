{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.kernel = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Custom kernel to use";
  };

  config = {
    # Required for cachyos kernel cache
    nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
    nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
    nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

    boot.kernelPackages =
      lib.mkIf (config.nixosModules.kernel != null)
        {
          cachyos_dell_prec_5550 = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
          cachyos_zen4 = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
          latest = pkgs.linuxPackages_latest;
          zen = pkgs.linuxKernel.packages.linux_zen;
        }
        .${config.nixosModules.kernel};
  };
}
