{pkgs, ...}: {
  imports = [
    ./lutris.nix
    ./steam.nix
  ];
  home = {
    packages = with pkgs; [gamescope];
    persistence = {
      # TODO: Change username
      "/persist/home/username" = {
        allowOther = true;
        directories = [
          {
            # Use symlink, as games may be IO-heavy
            directory = "Games";
            method = "symlink";
          }
        ];
      };
    };
  };
}
