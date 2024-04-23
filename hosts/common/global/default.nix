# This Nix expression configures settings used on all hosts.
{
  inputs,
  outputs,
  ...
}: {
  # Specify imports for common configurations
  imports = [
    # Import home-manager configuration
    inputs.home-manager.nixosModules.home-manager
    ./auto-upgrade.nix
    ./gamemode.nix
    ./locale.nix
    ./nix.nix
    #./steam-hardware.nix
    ./systemd-initrd.nix
  ];

  # Pass extra inputs and outputs to home-manager
  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  # Configure nixpkgs settings
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  networking.networkmanager.enable = true;
}
