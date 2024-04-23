# This Nix expression installs the wpa_supplicant_gui package for the home environment.
{pkgs, ...}: {
  home.packages = [pkgs.wpa_supplicant_gui];
}
