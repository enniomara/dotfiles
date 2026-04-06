{den, ...}: {
  me.home-common = {
    includes = [
      (den.provides.unfree ["1password-cli"])
    ];

    homeManager = {pkgs, ...}: {
      programs.home-manager.enable = true;
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
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

        pkgs.lazydocker

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
    };
  };
}
