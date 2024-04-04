{pkgs, ...}: {
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
