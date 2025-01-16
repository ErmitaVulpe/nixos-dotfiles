{ config, pkgs, lib, username, ... }:
let
  modules = a: ../../home/${a};
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  imports = config.users.users."${username}".homeImports;

  home.packages = with pkgs; [
    vulkan-tools
    virtualgl
  ];

  home.file = {
    # sex.text = "not real";
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
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
