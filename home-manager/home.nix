{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "marae";
  # home.homeDirectory = "/Users/marae";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  imports = [
    ./shell.nix
    ./tmux.nix
    ./neovim.nix
    ./work/aws.nix
    ./open-url-via-ssh
    ./betterTouchTool
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

  programs.git = {
    enable = true;
    extraConfig = {
      commit = {
        # sign all commits
        gpgsign = true;
      };
      gpg = {
        format = "ssh";
      };
      user = {
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      fetch = {
        # Automatically remove remote branches which have been removed from the
        # remote. Useful when combined with the clean-branches script, which
        # removes branches I have stopped working on.
        prune = true;
      };
    };
    aliases = {
      # used to remove the branches which have been merged
      "clean-branches" = "!git switch main && git pull --prune && git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" { print $1 }' | xargs -r git branch -D";
      "fu" = "!git fetch upstream";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = "true";
        features = "decorations";
        decorations = {
          commit-decoration-style = "yellow ol";
        };
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        # until https://github.com/cli/cli/issues/2329 lands
        prs = "!gh pr list | ${pkgs.peco}/bin/peco | awk '{print $1}' | xargs gh pr checkout";
      };
      protocol = "https";
    };
  };

  services.open-url-via-ssh.enable = true;

  programs.fzf = {
    enable = true;
    # false because shell.nix imports fzf
    enableZshIntegration = false;
  };

  home.packages = [
    pkgs.htop

    # pkgs.neovim

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
    pkgs.nushell
    pkgs.go-task

    pkgs.lazygit
    pkgs.lazydocker

    pkgs.awscli2
    pkgs.ssm-session-manager-plugin

    pkgs.rustup
    pkgs.duckdb
  ];
}
