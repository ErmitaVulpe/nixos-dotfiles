{ ... }:
{
  nixpkgs.overlays = [
    (import ../../overlays/fastfetch)
    (import ../../overlays/hyfetch)
    (import ../../overlays/nixos-icons)
  ];
}
