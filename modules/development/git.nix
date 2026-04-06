{lib, ...}: {
  me.git = {
    includes = [
      ({host, ...}:
        lib.optionalAttrs (host.class == "darwin") {
          homeManager.programs.git.settings."gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        })
    ];
    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.lazygit
        pkgs.gh-dash
      ];
      programs.git = {
        enable = true;
        settings = {
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
          alias = {
            # used to remove the branches which have been merged
            "clean-branches" = "!git switch main && git pull --prune && git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" { print $1 }' | xargs -r git branch -D";
            "fu" = "!git fetch upstream";
          };
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = "true";
          features = "decorations";
          decorations = {
            commit-decoration-style = "yellow ol";
          };
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
        '';
      };

      programs.zsh.shellAliases = {
        g = "git";
        gs = "git status";
        ga = "git add";
        gco = "git checkout";
        "gc!" = "git commit --verbose --amend";
        gc = "git commit --verbose";
        glog = "git log --oneline --decorate --graph";
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
    };
  };
}
