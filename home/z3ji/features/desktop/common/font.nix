# This Nix expression configures font profiles, specifying families and associated packages.
{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font"; # Specify family for monospace font
      package = pkgs.nerdfonts.override {fonts = ["FiraCode"];}; # Specify package for monospace font
    };
    regular = {
      family = "Fira Sans"; # Specify family for regular font
      package = pkgs.fira; # Specify package for regular font
    };
  };
}
