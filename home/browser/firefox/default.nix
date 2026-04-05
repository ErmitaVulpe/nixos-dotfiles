{ lib, config, ... }:
{
  options.homeModules.browser.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.homeModules.browser.firefox.enable {
    programs.firefox.enable = true;
  };
}
