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
    ./tmux
    ./work/aws.nix
    ./open-url-via-ssh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.configFile."kitty/kitty.conf".text = pkgs.lib.strings.concatStrings [
    (builtins.readFile ../kitty/.config/kitty/kitty.conf)
    (builtins.readFile ../kitty/.config/kitty/tokyo-night-moon.conf)
  ];

  services.open-url-via-ssh.enable = true;

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

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = [
    pkgs.watch
    pkgs.coreutils
    pkgs.findutils

    pkgs.htop

    # cli
    pkgs.autojump
    pkgs.fd
    pkgs.jq
    pkgs.jqp # live jq
    pkgs.ripgrep
    pkgs.tldr
    pkgs.kubectl
    pkgs.k9s
    pkgs.curl
    pkgs.go-task
    pkgs.uv

    pkgs.lazydocker

    pkgs.awscli2
    pkgs.ssm-session-manager-plugin

    pkgs.rustup
    pkgs.duckdb

    pkgs._1password-cli

    (pkgs.nixpkgs-unstable.python3.withPackages (ps:
      with ps; [
        llm
        llm-github-copilot
      ]))

    (pkgs.writeShellScriptBin "review" (builtins.readFile ../bin/review.bash))
  ];
}
