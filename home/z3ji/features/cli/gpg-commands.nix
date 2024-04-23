# This Nix expression defines a utility to check if the GPG agent is unlocked and a command to unlock it if necessary.
{pkgs, ...}: let
  # Define paths to SSH and gpg-connect-agent binaries
  ssh = "${pkgs.openssh}/bin/ssh";
  gpg_connect_agent = "${pkgs.gnupg}/bin/gpg-connect-agent";
in {
  # Check if the GPG agent is unlocked
  isUnlocked = "${pkgs.procps}/bin/pgrep 'gpg-agent' &> /dev/null && ${gpg_connect_agent} 'scd getinfo card_list' /bye | ${pkgs.gnugrep}/bin/grep SERIALNO -q";

  # Command to unlock the GPG agent
  unlock = "${ssh} -T localhost -o StrictHostKeyChecking=no exit";
}
