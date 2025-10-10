{ pkgs, ... }: {
  config = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        xauth_cmd = "${pkgs.xorg.xauth}/bin/xauth > /dev/null 2>&1";
      };
    };
  };
}

