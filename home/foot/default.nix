{ pkgs, ... }: {
  home.packages = with pkgs; [
    foot
  ];

  # home.file.".config/wezterm" = {
  #   source = ./config;
  #   recursive = true;
  # };
}
