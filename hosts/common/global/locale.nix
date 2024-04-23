# This Nix expression configures internationalization settings, location provider, and time zone.
{lib, ...}: {
  # Configure internationalization settings
  i18n = {
    # Specify the default locale
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    # Specify extra locale settings, such as LC_TIME
    extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault "en_GB.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "en_GB.UTF-8";
      LC_MEASUREMENT = lib.mkDefault "en_GB.UTF-8";
      LC_MONETARY = lib.mkDefault "en_GB.UTF-8";
      LC_NAME = lib.mkDefault "en_GB.UTF-8";
      LC_NUMERIC = lib.mkDefault "en_GB.UTF-8";
      LC_PAPER = lib.mkDefault "en_GB.UTF-8";
      LC_TELEPHONE = lib.mkDefault "en_GB.UTF-8";
      LC_TIME = lib.mkDefault "en_GB.UTF-8";
    };
    # Specify supported locales
    supportedLocales = lib.mkDefault [
      "en_GB.UTF-8/UTF-8"
    ];
  };
  # Specify the location provider
  location.provider = "geoclue2";
  # Specify the time zone
  time.timeZone = lib.mkDefault "Europe/London";
}
