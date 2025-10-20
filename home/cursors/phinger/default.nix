{ pkgs, ... }: {
  home.pointerCursor = rec {
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

