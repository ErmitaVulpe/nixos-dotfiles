{ config, ... }: {
  windowsToOpen = [ "wallpaper" ];
  yuck = ''
    (defvar wallpaper_path "${config.stylix.image}")
  ''
  + builtins.readFile ./eww.yuck;
}
