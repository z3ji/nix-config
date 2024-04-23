# This Nix expression imports configurations for various programs and sets up the home environment packages.
{
  imports = [
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./nix-index.nix
    ./pfetch.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [];
}
