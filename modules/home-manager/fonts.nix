# This Nix expression defines font profile options and configures font settings
# based on those options.
{
  # Import commonly used components from the input
  lib,
  config,
  ...
}: let
  # Define a function to create font options for a specific font profile
  mkFontOption = kind: {
    # Define options for font family
    family = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "Family name for ${kind} font profile";
      example = "Fira Code";
    };
    # Define options for font package
    package = lib.mkOption {
      type = lib.types.package;
      default = null;
      description = "Package for ${kind} font profile";
      example = "pkgs.fira-code";
    };
  };
  # Access the fontProfiles configuration from the input
  cfg = config.fontProfiles;
in {
  # Define options for font profiles
  options.fontProfiles = {
    enable = lib.mkEnableOption "Whether to enable font profiles";
    monospace = mkFontOption "monospace";
    regular = mkFontOption "regular";
  };

  # Configure fonts and home packages based on font profile settings
  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;
    home.packages = [cfg.monospace.package cfg.regular.package];
  };
}
