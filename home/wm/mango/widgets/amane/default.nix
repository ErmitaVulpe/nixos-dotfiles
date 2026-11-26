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

  amanePkg =
    let
      themeEnv = builtins.listToAttrs (
        map
          (name: {
            name = "STYLIX_${name}";
            value = config.lib.stylix.colors.${name};
          })
          [
            "base00"
            "base01"
            "base02"
            "base03"
            "base04"
            "base05"
            "base06"
            "base07"
            "base08"
            "base09"
            "base0A"
            "base0B"
            "base0C"
            "base0D"
            "base0E"
            "base0F"
          ]
      );
    in
    pkgs.rustPlatform.buildRustPackage {
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
        STYLIX_wallpaper = config.stylix.image;
      }
      // themeEnv;

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
  config = lib.mkMerge [
    {
      homeModules.wm.mango.widgets.amane = {
        package = amanePkg;
        start = pkgs.writeShellScript "${wm}-amane-start" ''
          ${cfg.package}/bin/${wm}-amane run
        '';
      };
    }
    (lib.mkIf cfg.dev {
      home.packages = [ amane ];
      xdg.configFile."amane/src".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home/wm/mango/widgets/amane/src";
    })
  ];
}
