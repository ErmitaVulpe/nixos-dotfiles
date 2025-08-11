{ pkgs, ... }: {
  # configures fish as the default shell https://nixos.wiki/wiki/Fish
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish = {
    enable = true;
    # Disable greeting
    interactiveShellInit = ''
      set fish_greeting
      set -x SHELL /home/winter/.nix-profile/bin/fish

      function fish_user_key_bindings
          bind \ee edit_cwd
      end
    '';
    shellAbbrs = {
      cls = "clear";
    };
    functions = {
      edit_cwd = {
        body = "$EDITOR .";
        description = "Opens CWD using the default editor";
      };
      ll = {
        body = "ls -lah $argv";
        wraps = "ls";
        description = "List contents of directory using long format";
      };
      ns = {
        body = ''
          if test (count $argv) -eq 0
              echo "Usage: ns <pkg1> [pkg2] [...]"
              return 1
          end
          set pkgs
          for pkg in $argv
              set pkgs $pkgs nixpkgs#$pkg
          end
          nix shell $pkgs
        '';
        description = "Shorthand for `nix shell`";
      };
    };
  };
}

