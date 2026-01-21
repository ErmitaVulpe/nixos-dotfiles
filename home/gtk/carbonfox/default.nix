{ pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      package = pkgs.nightfox-gtk-theme.override {
        colorVariants = [ "dark" ];
        # sizeVariants = [ "compact" ];
        themeVariants = [ "default" ];
        tweakVariants = [
          "black"
          "carbonfox"
        ];
        # iconVariants = [ "Duskfox-Alt" ];
      };
      name = "Nightfox-Dark-Carbonfox";
    };
  };
}
