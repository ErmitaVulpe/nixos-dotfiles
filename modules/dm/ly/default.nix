{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ xauth ];
  services.displayManager.ly = {
    enable = true;
    settings = {
      xauth_cmd = "${pkgs.xauth}/bin/xauth > /dev/null 2>&1";
    };
  };
}
