{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeModules.cursor;
in
{
  options.homeModules.cursor = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Custom cursor to use";
  };

  config = lib.mkIf (cfg != null) {
    home.pointerCursor = {
      enable = true;
    }
    // {
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
  };
}
