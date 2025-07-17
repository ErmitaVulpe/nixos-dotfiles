{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      uwuntu = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ ./configs/uwuntu ];
      };
      vmware = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ ./configs/vmware ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [ ./configs/wsl ];
      };
    };
  };
}
