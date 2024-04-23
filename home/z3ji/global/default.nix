# This Nix expression configures Home Manager, Nix settings, programs, and user home directory.
{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  # Specify imports for Impermanence home-manager module and homeManagerModules outputs
  imports =
    [
      inputs.impermanence.nixosModules.home-manager.impermanence
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  # Configure nixpkgs settings
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Configure Nix settings
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  # Configure programs
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # Specify user-related configurations
  home = {
    username = lib.mkDefault "z3ji";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/Documents/NixConfig";
    };

    # Configure home directory persistence
    #persistence = {
    #  "/persist/home/${config.home.username}" = {
    #    directories = [
    #      "Documents"
    #      "Downloads"
    #      "Pictures"
    #      "Videos"
    #      "MEGA"
    #      ".local/bin"
    #      ".local/share/nix" # Trusted settings and repl history
    #    ];
    #    allowOther = true;
    #  };
    #};
  };
}
