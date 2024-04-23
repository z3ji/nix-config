# This Nix expression configures Lutris and associated packages for the home environment.
{
  pkgs,
  lib,
  config,
  ...
}: {
  # Specify Lutris package and additional packages required for gaming
  home.packages = [
    (pkgs.lutris.override {
      extraPkgs = p: [
        p.wineWowPackages.staging
        p.pixman
        p.libjpeg
        p.gnome.zenity
      ];
    })
  ];

  # Configure persistence settings for user's home directory
  #home.persistence = {
  #  "/persist/home/${config.home.username}" = {
  #    allowOther = true;
  #    directories = [
  #      ".config/lutris"
  #      ".local/share/lutris"
  #    ];
  #  };
  #};
}
