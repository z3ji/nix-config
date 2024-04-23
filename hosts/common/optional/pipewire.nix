# This Nix expression configures real-time kernel support, audio subsystems, and enables the PipeWire service.
{
  security.rtkit.enable = true; # Enable real-time kernel support
  hardware.pulseaudio.enable = false; # Disable PulseAudio

  # Configure PipeWire service
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
