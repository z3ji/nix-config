{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.username = {
    # TODO: Change username
    isNormalUser = true;
    sheel = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "network"
        "docker"
        "git"
      ];

    packages = [pkgs.home-manager];
  };

  home-manager.users.username = import ../../../../home/username/${config.networking.hostName}.nix;
}
