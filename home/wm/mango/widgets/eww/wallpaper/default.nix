{ config, ... }: {
  windowsToOpen = [ "wallpaper" ];
  yuck = {
    prefix = ''
      (defvar wallpaper_path "${config.stylix.image}")
    '';
    source = ./eww.yuck;
  };
}
