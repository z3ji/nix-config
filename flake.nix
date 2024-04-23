# This Nix expression sets up a development environment with various inputs such as
# nixpkgs, home-manager, and other packages.
{
  # Inputs section specifies the dependencies of the project
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  # Outputs section defines the components that will be produced by this flake
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # Inherit outputs from self
    inherit (self) outputs;
    # Combine libraries from nixpkgs and home-manager
    lib = nixpkgs.lib // home-manager.lib;
    # Define supported systems
    systems = ["x86_64-linux"];
    # Generate packages for each supported system
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    # Generate packages for each supported system using nixpkgs
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    # Inherit commonly used components
    inherit lib;
    # Import home-manager modules
    homeManagerModules = import ./modules/home-manager;

    # Define packages for each supported system
    packages = forEachSystem (pkgs: {inherit pkgs;});

    # Define nixosConfigurations for desktop and laptop
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        modules = [./hosts/desktop];
        specialArgs = {inherit inputs outputs;};
      };
      laptop = lib.nixosSystem {
        modules = [./hosts/laptop];
        specialArgs = {inherit inputs outputs;};
      };
    };

    # Define homeConfigurations for desktop and laptop users
    # FIXME: Figure out a way to remove the hardcoded usernames in './home/[username]/'
    homeConfigurations = {
      "z3ji@desktop" = lib.homeManagerConfiguration {
        modules = [./home/z3ji/desktop.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
      "z3ji@laptop" = lib.homeManagerConfiguration {
        modules = [./home/z3ji/laptop.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
      # No impermanence
      "z3ji@generic" = lib.homeManagerConfiguration {
        modules = [./home/z3ji/generic.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
