{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.homeModules.gtkTheme = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Gtk theme to use";
  };

  config.gtk =
    if config.homeModules.gtkTheme == null then
      { enable = false; }
    else
      lib.recursiveUpdate
        {
          gtk4.theme = null;
        }
        {
          carbonfox = {
            enable = true;
            colorScheme = "dark";
            theme = {
              package = pkgs.nightfox-gtk-theme.override {
                colorVariants = [ "dark" ];
                themeVariants = [ "default" ];
                tweakVariants = [
                  "black"
                  "carbonfox"
                ];
              };
              name = "Nightfox-Dark-Carbonfox";
            };
          };
        }
        .${config.homeModules.gtkTheme};
}
