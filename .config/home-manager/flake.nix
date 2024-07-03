{
  description = "Home Manager configuration of kios";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nyaa = {
      url = "github:/Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    catppuccin,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs {
      inherit system;
      # overlays = [self.overlays.default];
    };
  in {
    homeConfigurations."kios" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      extraSpecialArgs = {
        inherit spicetify-nix;
        inputs = inputs;
      };
      modules = [
        ./home.nix
        ./programs/spotify/default.nix
        catppuccin.homeManagerModules.catppuccin
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
