{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = true;
  users.users.username = {
    # TODO: Change username
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "networkmanager"
        "network"
        "docker"
        "git"
      ];

    packages = [pkgs.home-manager];
  };
  programs.zsh.enable = true;

  home-manager.users.username = import ../../../../home/username/${config.networking.hostName}.nix;
}
