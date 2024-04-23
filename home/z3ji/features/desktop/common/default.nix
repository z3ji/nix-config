# This Nix expression imports configurations for Firefox, font settings, and GTK.
{
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
  ];
}
