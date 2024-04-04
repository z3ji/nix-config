{
  config,
  pkgs,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.regular.family;
      size = 12;
    };
  };

  services.xsettingsd = {
    enable = true;
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
