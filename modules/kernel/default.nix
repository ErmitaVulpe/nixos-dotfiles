{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.nixosModules.kernel = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "cachyos_dell_prec_5550"
        "latest"
        "zen"
      ]
    );
    description = "Custom kernel to use";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.nixosModules.kernel == "cachyos_dell_prec_5550") {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

      nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
      nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
    })

    (lib.mkIf (config.nixosModules.kernel == "latest") {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    })

    (lib.mkIf (config.nixosModules.kernel == "zen") {
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    })
  ];
}
