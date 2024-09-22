{
  # inputs.hyprland.url = "github:hyprwm/Hyprland?submodules=1";
  inputs.hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.aagl-gtk-on-nix = {
    url = "github:ezKEa/aagl-gtk-on-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nur.url = "github:nix-community/NUR";


  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [ ./configuration.nix ];
    };
  };
}
