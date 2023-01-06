{ config, pkgs, ... }:

{
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
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.packer-nvim
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "autojump"
        "git"
        "fzf"
        "kubectl"
        "tmux"
      ];
    };
    shellAliases = {
      gs = "git status";
      ccat = "cat";
      cat = "bat";
    };
    envExtra = ''
      # The terminal in tmux in kitty did not render characters correctly. This fixed
      # that see link below for details
      # https://github.com/sindresorhus/pure/issues/300#issuecomment-386371460
      export LANG=en_US.UTF-8
      export LC_CTYPE=en_US.UTF-8
    '';
    shellGlobalAliases = {
      L = "| less";
    };
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "v1.20.4";
          sha256 = "sha256-e1D+9EejlVZxOyErg6eRgawth5gAhv6KpgjhK06ErZc=";
        };
      }
    ];
  };

  home.packages = [
    pkgs.htop

    # pkgs.neovim

    # cli
    pkgs.autojump
    pkgs.fd
    pkgs.jq
    pkgs.ripgrep
    pkgs.tldr
    pkgs.fzf

    pkgs.tmux

    pkgs.gh
  ];
}
