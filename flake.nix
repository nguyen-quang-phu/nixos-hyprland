{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:aylur/ags";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    muxbar = {
      url = "github:dlurak/muxbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    retch = {
      url = "github:dlurak/retch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    ags,
    spicetify-nix,
    agenix,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs ags spicetify-nix;};
      modules = [
        agenix.nixosModules.default
        inputs.home-manager.nixosModules.default
        ./nixOsModules
        ./hosts/nixos/configuration.nix
      ];
    };
    nixosConfigurations.nix-malina = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./nixOsModules
        ./hosts/nix-malina/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
