{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  config = {
    services.fwupd.enable = true;
  };
}
