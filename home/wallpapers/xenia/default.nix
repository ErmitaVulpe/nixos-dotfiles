{ pkgs, ... }:
{
  home.file.".local/share/backgrounds/default.png" = {
    source = ./wallpaper.png;
  };
}
