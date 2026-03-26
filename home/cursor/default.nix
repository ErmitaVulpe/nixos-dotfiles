{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.cursor = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Custom cursor to use";
  };

  config.home.pointerCursor =
    if config.homeModules.cursor == null then
      { enable = false; }
    else
      {
        phinger = rec {
          name = "phinger-cursors-dark";
          package = pkgs.phinger-cursors;
          size = 20;
          gtk.enable = true;
          x11 = {
            enable = true;
            defaultCursor = name;
          };
        };
      }
      .${config.homeModules.cursor};
}
