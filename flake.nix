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
    # Do not override its nixpkgs input, otherwise there can be mismatch between
    # patches and kernel version
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    fsel = {
      url = "github:Mjoyufull/fsel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    otter-launcher = {
      url = "github:kuokuo123/otter-launcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
        flareon = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./configs/flareon ];
        };
        sylveon = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./configs/sylveon ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./configs/wsl ];
        };
      };
    };
}
