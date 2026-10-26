{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.wm.mango.widgets.amane;
  wm = "mango";
  amane = inputs.amane.packages.x86_64-linux.default;

  amanePkg = pkgs.rustPlatform.buildRustPackage {
    name = "${wm}-amane";
    version = "0.1.0";

    src = lib.cleanSourceWith {
      src = ./.;
      filter = name: type: !(lib.hasSuffix ".nix" (baseNameOf name));
    };

    cargoLock = {
      lockFile = ./Cargo.lock;
      outputHashes = {
        "amane-0.1.2" = "sha256-fU20wtIC9wlOP9mvcCboSdB67zVq2ZSe9FjD7mwyHMc=";
      };
    };

    nativeBuildInputs = with pkgs; [
      pkg-config
      fontconfig
    ];

    env = {
      LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
        pkgs.vulkan-loader
        pkgs.wayland
      ];
    };

    buildInputs = with pkgs; [
      fontconfig
      libpulseaudio
      libxkbcommon
      linux-pam
      vulkan-loader
      wayland
      wayland-protocols

      makeWrapper
      amane
    ];

    postInstall = ''
      mkdir -p $out/amane/
      mv $out/bin/amane-shell $out/amane/amane-shell

      makeWrapper ${amane}/bin/amane $out/bin/${wm}-amane \
        --set XDG_CACHE_HOME "$out"
    '';
  };
in
{
  config = {
    homeModules.wm.mango.widgets.amane = {
      package = amanePkg;
      start = pkgs.writeShellScript "${wm}-amane-start" ''
        ${cfg.package}/bin/${wm}-amane run
      '';
    };

    xdg.configFile."amane/src" = lib.mkIf cfg.dev {
      source = config.lib.file.mkOutOfStoreSymlink ./src;
    };
  };
}
