{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../home
  ];

  homeModules = lib.recursiveUpdate config.users.users."${username}".config {
    iamb = {
      defaultProfile = "Zerda";
      profiles = {
        ErmitaVulpe = "@ermitavulpe:matrix.org";
        Zerda = "@zerda:simplybush.pl";
      };
    };
    shell.fish.enable = true;
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  home.file = {
    # sex.text = "not real";
  };

  home.sessionVariables = {
    # pixel scrolling in firefox
    # see: https://askubuntu.com/questions/1148934/precise-scrolling-in-firefox
    MOZ_USE_XINPUT2 = 1;
  };

  programs = {
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    git = {
      enable = true;
      settings = {
        credential = {
          helper = "store";
        };
        init.defaultBranch = "main";
        merge.tool = "nvimdiff";
        mergetool.keepBackup = false;
        pull.rebase = false;
        user = {
          email = "emily.wilczek@proton.me";
          name = "ErmitaVulpe";
        };
      };
      ignores = [
        "nix.profile*"
      ];
      signing.format = null;
    };
    neovim = {
      vimAlias = true;
      viAlias = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
