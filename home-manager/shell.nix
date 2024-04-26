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

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
        golang = "1.21";
        nodejs = "18";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    completionInit = /* bash */ "
      zstyle ':completion:*:*:*:*:*' menu select

      # Complete . and .. special directories
      zstyle ':completion:*' special-dirs true

      # Give completion list color support
      zstyle ':completion:*' list-colors ''
    ";
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      gs = "git status";
      ga = "git add";
      gco = "git checkout";
      "gc!" = "git commit --verbose --amend";
      gc = "git commit --verbose";
      glog = "git log --oneline --decorate --graph";
      ccat = "cat";
      cat = "bat";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      la = "ls -lAh";

      k = "kubectl";
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

      # attempt to fix problems like libc++ not found when running python
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib64:$LD_LIBRARY_PATH";
    };
    localVariables = {
      RPROMPT = "%F{8}%*";
      EDITOR = "nvim";
      # zsh by default has a list of chars (- / # etc) which can be used as a
      # separator but still be called a word. Annoying thing since running
      # Ctrl-W on "nixpkgs#git" removed the entire word, instead of returning
      # "nixpkgs#
      WORDCHARS = "";

      # Disable pure's (zsh theme) automatic git fetching. Very annoying to get
      # the authentication popup every time
      PURE_GIT_PULL = 0;
    };
    shellGlobalAliases = {
      L = "| less";
      G = "| grep -i";
      H = "--help";
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
      save = 1000000;
      size = 5000000;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "$HOME/.zsh_history";
      expireDuplicatesFirst = true;
      share = true; # share history between zsh sessions
    };
    defaultKeymap = "viins";
    initExtra = /* bash */''
      # get Delete button working
      bindkey -M emacs "^[[3~" delete-char
      bindkey "^o" accept-line  # enter on Ctrl-O

      # better vi integration
      # initialize ZVM as sson as it's called. Workaround so that it doesn't
      # override bindings in fzf
      export ZVM_INIT_MODE=sourcing
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # load fzf
      source ${pkgs.fzf}/share/fzf/completion.zsh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
    '';
  };
}
