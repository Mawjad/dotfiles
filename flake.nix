{
  description = "MAWJAD FLAKE";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      # ---- PACKAGES ---- #
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    
      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        system = "x86_64-linux";
        hostname = "MAWJAD";
        timezone = "America/Phoenix";
        locale = "en_US.UTF-8";
      };
      # ---- USER SETTINGS ---- #
      userSettings = {
        username = "mawjad";
        name = "George Alsen Stone";
        email = "alonelypoet@protonmail.com";
        dotfilesDir = "~/.dotfiles";
        editor = "helix";
      };
    in
    {
    nixosConfigurations = {
      MAWJAD = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix];
        # pass config variables from above
        specialArgs = {
          inherit pkgs-unstable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
    homeConfigurations = {
      mawjad = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
        # pass config variables from above
          inherit pkgs-unstable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
  
}
