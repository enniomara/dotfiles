{pkgs, ...}: {
  programs.zsh = {
    sessionVariables = {
      GOPRIVATE = "gittools.se.axis.com,github.com/axteams-one";
    };

    shellAliases = {
      with_clickhouse = "${pkgs.clickhouse}/bin/clickhouse-client --secure --user=$USER --password=$(${pkgs._1password-cli}/bin/op read op://Work/7qbwhze42bf6hgqdn34jbiwmzm/password)";
    };
  };

  programs.fish = {
    shellInit =
      # fish
      ''
        set -g -x GOPRIVATE "gittools.se.axis.com,github.com/axteams-one"
      '';

    shellAliases = {
      with_clickhouse = "${pkgs.clickhouse}/bin/clickhouse-client --secure --user=$USER --password=$(${pkgs._1password-cli}/bin/op read op://Work/7qbwhze42bf6hgqdn34jbiwmzm/password)";
    };
  };

  programs.git = {
    userName = "Ennio Mara";
    userEmail = "marae@axis.com";
    extraConfig = {
      url = {
        "ssh://marae@gittools.se.axis.com:29418/" = {
          insteadOf = "https://gittools.se.axis.com/gerrit/a/";
        };
      };
    };
  };

  home.file = {
    PublicKey = {
      source = ../ssh_work_key.pub;
      target = ".ssh/id_ed25519.pub";
    };
  };
}
