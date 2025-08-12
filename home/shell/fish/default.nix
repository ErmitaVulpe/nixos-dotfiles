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
      fish_prompt = {
        description = "Write out the prompt";
        body = ''
          set -l last_pipestatus $pipestatus
          set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
          set -l normal (set_color normal)
          set -q fish_color_status
          or set -g fish_color_status red

          # Color the prompt differently when we're root
          set -l color_cwd $fish_color_cwd
          set -l suffix '>'
          if functions -q fish_is_root_user; and fish_is_root_user
              if set -q fish_color_cwd_root
                  set color_cwd $fish_color_cwd_root
              end
              set suffix '#'
          end

          # Write pipestatus
          # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
          set -l bold_flag --bold
          set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
          if test $__fish_prompt_status_generation = $status_generation
              set bold_flag
          end
          set __fish_prompt_status_generation $status_generation
          set -l status_color (set_color $fish_color_status)
          set -l statusb_color (set_color $bold_flag $fish_color_status)
          set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

          echo -n -s $SHLVL " " (prompt_login) ':' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " " $prompt_status $suffix " "
        '';
      };
      ll = {
        description = "List contents of directory using long format";
        wraps = "ls";
        body = "ls -lah $argv";
      };
      ns = {
        description = "Shorthand for `nix shell`";
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
      };
    };
  };
}

