{
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "marae";
  # home.homeDirectory = "/Users/marae";

  imports = [
    ./shell.nix
    ./open-url-via-ssh
  ];

  programs.fzf = {
    enable = true;
    # false because shell.nix imports fzf
    enableZshIntegration = false;
  };

  services.ollama = {
    enable = true;
    package = pkgs.nixpkgs-unstable.ollama;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "8192";
    };
  };
}
