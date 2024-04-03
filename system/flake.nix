{
  inputs.hyprland.url = "github:hyprwm/Hyprland";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";


  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [ ./configuration.nix ];
    };
  };
}
