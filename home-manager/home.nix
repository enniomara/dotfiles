{
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
    ./tmux
    ./neovim.nix
    ./work/aws.nix
    ./open-url-via-ssh
    ./betterTouchTool
    ./vscode.nix
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

  programs.jujutsu = {
    enable = true;
    package = pkgs.nixpkgs-unstable.jujutsu;
    settings = {
      signing = {
        behaviour = "drop"; # commits are signed on push (via git.sign-on-push)
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
        backends = {
          ssh = lib.mkIf pkgs.stdenv.isDarwin {
            program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          };
        };
      };

      git = {
        sign-on-push = true;
      };

      templates = {
        # show the diff in the editor when drafting description. I.e. similar to git commit -v
        draft_commit_description = ''
          concat(
            builtin_draft_commit_description,
            "\nJJ: ignore-rest\n",
            diff.git(),
          )
        '';
      };

      template-aliases = {
        # from https://github.com/jj-vcs/jj/issues/7702
        "list_first(list)" = "stringify(list.join('\n')).first_line()";
        "first_bookmark_name(bookmarks)" = "list_first(bookmarks.map(|b| b.name()))";
      };

      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
      };

      aliases = {
        tug = ["bookmark" "move" "--from" "heads(::@- & bookmarks())" "--to" "@-"];
        # PR create
        prc = [
          "util"
          "exec"
          "--"
          "bash"
          "-c"
          # If we are using a fork, then gh pr create needs the full ref, i.e. <user>:<branch>
          # bash
          ''
            gh pr create --head "$(gh api user -q .login):$(jj log -r 'closest_bookmark(@)' -T 'bookmarks' --no-graph | cut -d ' ' -f 1)"
          ''
        ];
        prw = [
          "util"
          "exec"
          "--"
          "bash"
          "-c"
          # sleep to allow time for github to register the new PR and start
          # checks. Otherwise it returns no checks found
          # bash
          ''
            sleep 5 && \
            gh pr checks --watch $(
              gh pr list \
                --head $(jj log -r 'closest_bookmark(@)' -T 'first_bookmark_name(remote_bookmarks)' --no-graph) \
                --json number \
                -q '.[0].number'
            ) && \
            osascript -e 'display notification "PR checks finished" with title "Github PR"'
          ''
        ];
        gf = ["git" "fetch" "--all-remotes"];
        c = "commit";
      };

      "--scope" = [
        {
          when.commands = ["diff" "show"];
          ui = {
            pager = "delta";
            diff-formatter = ":git";
          };
        }
      ];
    };
  };

  xdg.configFile."git/ignore" = {
    # By default git looks here as the last step when ignoring files. This file
    # acts as a global gitignore
    # https://git-scm.com/docs/gitignore
    text = ''
      .aider*
      !.aider.conf.yml
      !.aiderignore
      .jj
    '';
  };

  xdg.configFile."ghostty/config" = {
    text = ''
      theme = TokyoNight Moon
      # the default scroll (of 1) jumps way too much. Make it more like kitty
      mouse-scroll-multiplier = 0.5

      font-family = Iosevka NFM
      font-size = 16
      macos-titlebar-style = tabs
    '';
  };

  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        # until https://github.com/cli/cli/issues/2329 lands
        prs = "!gh pr list --author '@me' | ${pkgs.fzf}/bin/fzf | awk '{print $1}' | xargs gh pr checkout";
        prS = "!gh pr list | ${pkgs.fzf}/bin/fzf | awk '{print $1}' | xargs gh pr checkout";
        prc = "pr create";
        pro = "pr view --web";
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

  services.ollama = {
    enable = true;
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

    pkgs.lazygit
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

    pkgs.gh-dash
    pkgs.lazyjj
    pkgs.jjui
  ];
}
