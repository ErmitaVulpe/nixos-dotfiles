{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  username = "winter";
in
{
  options = with lib.types; {
    users.users = lib.mkOption {
      type = attrsOf (submodule {
        options.homeImports = lib.mkOption {
          type = listOf (oneOf [
            path
            deferredModule
          ]);
          default = [ ];
          description = "list of additional home modules for this user";
        };
      });
    };
  };

  config = {
    users.users."${username}" = {
      isNormalUser = true;
      group = "${username}";
      extraGroups = [
        "network"
        "wheel"
        "wireshark"
      ];
      initialHashedPassword = "$y$j9T$CJyHPv2s.on.ZRekXaXL50$h6cGCKZU2nKZ/zarN1hWLM8oU99rvBGBs9DG2qtl3yB";
    };
    users.groups."${username}" = { };
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
      };
      users."${username}" = import ./home.nix {
        inherit
          config
          inputs
          lib
          pkgs
          username
          ;
      };
    };
  };
}
