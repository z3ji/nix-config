{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
  ];

  #xdg.portal.enable = true;
}
