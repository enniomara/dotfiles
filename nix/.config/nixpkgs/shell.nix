{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

  # brings color to ls
  programs.dircolors.enable = true;

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
    sessionVariables = {
      # The terminal in tmux in kitty did not render characters correctly. This fixed
      # that see link below for details
      # https://github.com/sindresorhus/pure/issues/300#issuecomment-386371460
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";

      # Configure less to behave consistently across environments
      # -M, prompt more in the screen
      # -q quiet, do not ring bell
      # -i ignore case
      # -R color output
      LESS = "MqiR";
    };
    localVariables = {
      RPROMPT = "%F{8}%*";
      EDITOR = "nvim";
    };
    shellGlobalAliases = {
      L = "| less";
      G = "| grep -i";
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
    history = {
      save = 10000;
      size = 50000;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "$HOME/.zsh_history";
      expireDuplicatesFirst = true;
      share = true; # share history between zsh sessions
    };
    initExtra = ''
      # asdf - need to source to add shim path to PATH
      source "${pkgs.asdf-vm}/etc/profile.d/asdf-prepare.sh"
    '';
  };
}
