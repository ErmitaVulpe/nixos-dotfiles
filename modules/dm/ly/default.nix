{ config, lib, pkgs, inputs, ... }: with lib; {
  config = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        # xauth_cmd = "$PREFIX_DIRECTORY/bin/xauth";
        xauth_cmd = "${pkgs.xorg.xauth}/bin/xauth > /dev/null 2>&1";
        # x_cmd = "$PREFIX_DIRECTORY/bin/X";
      };
    };
  };
}

