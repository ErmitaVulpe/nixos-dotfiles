{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.theme.wallpaper;
  fileLut = {
    xenia = ./xenia/xenia.png;
  };
in
{
  options.homeModules.theme.wallpaper = lib.mkOption {
    type = lib.types.nullOr (lib.types.enum [ "xenia" ]);
    default = null;
    description = "Wallpaper to use";
  };

  config = lib.mkIf (cfg != null) {
    stylix.image = fileLut.${cfg};
    stylix.polarity = "dark";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    home.file.".local/share/backgrounds/default.png" = {
      source = fileLut.${cfg};
    };
  };
}
