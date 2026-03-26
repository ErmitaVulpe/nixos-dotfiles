{
  config,
  lib,
  ...
}:
{
  options.homeModules.wallpaper = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Wallpaper to expose";
  };

  config =
    lib.mkIf (config.homeModules.wallpaper != null) {
      home.file.".local/share/backgrounds/default.png" = {
        source = ./. + "/${config.homeModules.wallpaper}/wallpaper.png";
      };
    };
}
