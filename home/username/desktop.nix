{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./global
    ./features/desktop/wireless
    ./features/desktop/gnome
    ./features/productivity
    ./features/games
  ];
}
