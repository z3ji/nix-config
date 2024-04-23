# This Nix expression configures Nix settings, garbage collection, and Nix paths.
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = {
    # Specify the Nix package version
    package = pkgs.nixVersions.nix_2_18;

    # Configure Nix settings
    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };

    # Configure garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +3"; # Keep last 3 generations
    };

    # Add each flake input as a registry to make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # Add nixpkgs input to NIX_PATH to allow nix2 commands to use <nixpkgs>
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };
}
