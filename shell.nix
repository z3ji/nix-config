# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs ?
  # If pkgs is not defined, instanciate nixpkgs from locked commit
  let
    # Read the locked commit from flake.lock
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    # Fetch the nixpkgs tarball from GitHub based on the locked commit
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    # Import nixpkgs
    import nixpkgs {overlays = [];},
  ...
}: {
  # Define default shell
  default = pkgs.mkShell {
    # Set NIX_CONFIG for enabling experimental features like nix-command and flakes
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    # Define native build inputs
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
      gnupg
    ];
  };
}
