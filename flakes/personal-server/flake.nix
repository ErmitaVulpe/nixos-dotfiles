{
  description = "Public interface, for a private flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    personal-server = {
      url = "git+ssh://git@github.com/ErmitaVulpe/personal-server.git?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { personal-server, ... }: personal-server.outputs;
}
