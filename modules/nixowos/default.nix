{ ... }:
{
  nixpkgs.overlays = [
    (import ./overlays/fastfetch)
    (import ./overlays/nixos-icons)
  ];

  system.nixos = {
    distroName = "NixOwOS";
    distroId = "nixowos";
  };
}
