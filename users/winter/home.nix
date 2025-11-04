{ config, username, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  imports = config.users.users."${username}".homeImports;

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
        user = {
          email = "tymon.wilczek@gmail.com";
          name = "ErmitaVulpe";
        };
        credential = {
          helper = "store";
        };
      };
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

