# This Nix expression enables systemd in the initrd.
{
  boot.initrd.systemd.enable = true;
}
