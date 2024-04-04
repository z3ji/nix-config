{
  pkgs,
  lib,
  ...
}: {
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

  # TODO: Change username
  home.persistence = {
    "/persist/home/username" = {
      allowOther = true;
      directories = [
        ".config/lutris"
        ".local/share/lutris"
      ];
    };
  };
}
