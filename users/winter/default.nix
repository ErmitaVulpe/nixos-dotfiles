{ config, pkgs, lib, inputs, ... }:
let
  username = "winter";
in
{
  options = {
    users.users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options.homeImports = lib.mkOption {
          type = lib.types.listOf lib.types.path;
          default = [];
          description = "list of additional home modules for this user";
        };
      });
    };
  };

  config = {
    users.users."${username}" = {
      isNormalUser = true;
      group = "${username}";
      extraGroups = [ "wheel" "network" ];
      initialHashedPassword = "$y$j9T$CJyHPv2s.on.ZRekXaXL50$h6cGCKZU2nKZ/zarN1hWLM8oU99rvBGBs9DG2qtl3yB";
    };
    users.groups."${username}" = {};
    home-manager = {
      users."${username}" = import ./home.nix { inherit config pkgs lib inputs username; };
    };
  };
}
