{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gimp
    vlc
    wireshark
  ];
  programs.wireshark.enable = true;
}
