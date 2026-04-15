{
  me.jujutsu.homeManager = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [
      pkgs.lazyjj
      pkgs.jjui
    ];

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
          work = [
            "util"
            "exec"
            "--"
            "bash"
            "-c"
            ''
              set -ex
              echo "$@"
              branch="$1"

              jj git fetch --all-remotes
              jj new "$branch@upstream"
              jj bookmark track "$branch" --remote upstream
            ''
            "" # needed otherwise arugments are not passed to the bash script
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

    # By default git looks here as the last step when ignoring files. This file
    # acts as a global gitignore
    # https://git-scm.com/docs/gitignore
    xdg.configFile."git/ignore".text = lib.mkAfter ''
      .jj
    '';
  };
}
