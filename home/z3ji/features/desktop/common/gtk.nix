# This Nix expression configures GTK settings and enables xsettingsd service.
{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Configure GTK settings
  gtk = {
    enable = true;
    font = {
      # Set font name based on regular font family from font profiles in configuration
      name = config.fontProfiles.regular.family;
      size = 12;
    };
  };

  # Enable xsettingsd service
  services.xsettingsd = {
    enable = true;
  };
}
