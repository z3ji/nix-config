# This Nix expression configures user accounts and their associated settings.
{
  # Import commonly used components from the input
  pkgs,
  config,
  ...
}: let
  # Function to filter existing groups
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Enable mutable users
  users.mutableUsers = true;

  # Configure user account settings for a specific user
  users.users = {
    z3ji = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups =
        [
          "wheel"
          "input"
          "video"
          "audio"
          "disk"
        ]
        ++ ifTheyExist [
          "networkmanager"
          "docker"
          "git"
          "vboxusers"
        ];

      packages = [pkgs.home-manager];
    };
  };

  # Enable zsh shell
  programs.zsh.enable = true;

  # Configure Home Manager settings for the user
  # FIXME: Don't hardcode usernames here
  home-manager.users.z3ji = import ../../../../home/z3ji/${config.networking.hostName}.nix;
}
