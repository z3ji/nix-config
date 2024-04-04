{pkgs, ...}: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview];
    settings = {
      version = "1";
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
  # TODO: Change username
  home.persistence = {
    "/persist/home/username".directories = [".config/gh"];
  };
}
