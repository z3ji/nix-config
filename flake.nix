{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux"];
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;
    #nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    #overlays = import ./overlays {inherit inputs outputs;};

    packages = forEachSystem (pkgs: {inherit pkgs;});

    nixosConfigurations = {
      # Desktop
      desktop = lib.nixosSystem {
        modules = [./hosts/desktop];
        specialArgs = {inherit inputs outputs;};
      };
      # Laptop
      laptop = lib.nixosSystem {
        modules = [./hosts/laptop];
        specialArgs = {inherit inputs outputs;};
      };
    };

    # TODO: Add username
    homeConfigurations = {
      "username@desktop" = lib.homeManagerConfiguration {
        modules = [./home/username/desktop.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
      "username@laptop" = lib.homeManagerConfiguration {
        modules = [./home/username/laptop.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
