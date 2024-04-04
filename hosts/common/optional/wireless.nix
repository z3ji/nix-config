{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.wireless = {
    enable = true;
  };
  # Ensure group exists
  users.groups.network = {};
}
